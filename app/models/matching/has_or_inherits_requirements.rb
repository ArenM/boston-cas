# The unwitting consequence of decentralizing the network of requirements was
# that I had to put code in place to avoid inifinitely looping (in two
# different ways). There are a few different ways this code can be improved.
module Matching::HasOrInheritsRequirements
  extend ActiveSupport::Concern

  included do
    def requirements_with_inherited(eager_load = true, ancestors = [])
      me =
        if eager_load
          self.class.eager_load_requirements_with_inherited.find(id)
        else
          self
        end
      me.direct_requirements + me.inherited_requirements(ancestors)
    end

    def requirements_for_archive
      requirements_with_inherited.map(&:prepare_for_archive)
    end

    def direct_requirements
      self.class.associations_for_direct_requirements.map { |r| send(r) }.flatten
    end

    def inherited_requirements(ancestors)
      ancestry = ancestors + [[self.class, id]]
      self.class.associations_adding_requirements.map do |association|
        Array.wrap(send(association)).map do |record|
          unless ancestry.include? [record.class, record.id]
            record.requirements_with_inherited(false, ancestry)
          end
        end.flatten
      end.flatten
    end

    def requirements_have_changed?
      requirements_changes.any?
    end

    def requirements_changes_ids
      requirements_changes.map { |r| r['rule_id'] }
    end

    def requirements_changes
      current_requirements = requirements_with_inherited.map do |r|
        r.slice('rule_id', 'positive')
      end.sort_by do |r|
        r['rule_id']
      end

      initial_requirements = begin
        universe_state.try(:[], 'requirements').map do |r|
          r.slice('rule_id', 'positive')
        end.sort_by do |r|
          r['rule_id']
        end
                             rescue Exception
                               []
      end

      current_requirements - initial_requirements
    end

    def self.eager_load_requirements_with_inherited
      eager_load(*associations_for_requirements_with_inherited)
    end

    def self.associations_for_requirements_with_inherited(ancestors_calls = [])
      inherited = associations_for_inherited_requirements(ancestors_calls)
      associations_for_direct_requirements + (inherited.empty? ? [] : [inherited])
    end

    def self.associations_for_inherited_requirements(ancestors_calls)
      Hash[associations_adding_requirements.map do |association|
        [association, associations_for_association_with_requirements(association, ancestors_calls)]
      end.select { |_association, children| children }]
    end

    def self.associations_for_association_with_requirements(association, ancestors_calls)
      method = :associations_for_requirements_with_inherited
      begin
        raise ":#{association} given as association with requirements for #{self} but #{association_class(association)} is missing #{method} method." unless association_class(association).respond_to?(method)

        send_to_association_class(association, method, ancestors_calls)
      rescue ClassMethodLoopException
        nil
      end
    end

    def self.associations_for_direct_requirements
      reflect_on_association(:requirements) ? [:requirements] : []
    end

    def self.associations_adding_requirements
      []
    end

    def self.send_to_association_class(association, method, ancestors_calls = [])
      ancestry_calls = ancestors_calls + [[self, method]]
      raise ClassMethodLoopException, "A loop through class method calls has been detected when calling #{association_class(association)}.#{method}." if ancestry_calls.include? [association_class(association), method]

      association_class(association).send(method, ancestry_calls)
    end

    def self.association_class(association)
      reflect_on_association(association).class_name.constantize
    end
  end

  class ClassMethodLoopException < StandardError; end
end
