###
# Copyright 2016 - 2020 Green River Data Analysis, LLC
#
# License detail: https://github.com/greenriver/boston-cas/blob/master/LICENSE.md
###

module MatchDecisions::ProviderOnly
  class HsaAcknowledgesReceipt < ::MatchDecisions::Base
    def to_partial_path
      'match_decisions/hsa_acknowledges_receipt'
    end
    include MatchDecisions::AcceptsDeclineReason

    validate :cant_accept_if_match_closed
    validate :cant_accept_if_client_has_related_active_match
    validate :cant_accept_if_opportunity_has_related_active_match
    validate :ensure_required_contacts_present_on_accept

    def label_for_status status
      case status.to_sym
      when :pending then "New Match Awaiting Acknowledgment by #{_('HSA')}"
      when :acknowledged then "Match acknowledged by #{_('HSA')}.  In review"
      when :canceled then canceled_status_label
      end
    end

    def started?
      status&.to_sym == :acknowledged
    end

    def step_name
      "New Match for #{_('HSA')}"
    end

    def actor_type
      _('HSA')
    end

    def contact_actor_type
      nil
    end

    def statuses
      {
        pending: 'Pending',
        acknowledged: 'Acknowledged',
        canceled: 'Canceled',
        destroy: 'Destroy',
      }
    end

    def editable?
      super && saved_status !~ /acknowledged/
    end

    def initialize_decision! send_notifications: true
      super(send_notifications: send_notifications)
      update status: :pending
      send_notifications_for_step if send_notifications
    end

    def accessible_by? contact
      contact.user_can_act_on_behalf_of_match_contacts? ||
      contact.in?(match.housing_subsidy_admin_contacts)
    end

    def notifications_for_this_step
      @notifications_for_this_step ||= [].tap do |m|
        m << Notifications::ProviderOnly::MatchInitiationForHsa
        m << Notifications::ProviderOnly::MatchInitiationForShelterAgency
        m << Notifications::ProviderOnly::MatchInitiationForSsp
      end
    end

    class StatusCallbacks < StatusCallbacks
      def pending
      end

      def acknowledged
        @decision.next_step.initialize_decision!

        if !match.client.non_hmis? && match.client.remote_id.present? && Warehouse::Base.enabled?
          Warehouse::Client.find(match.client.remote_id).queue_history_pdf_generation rescue nil
        end
      end

      def canceled
        Notifications::MatchCanceled.create_for_match! match
        match.canceled!
      end
    end
    private_constant :StatusCallbacks

    private def save_will_accept?
      saved_status == 'pending' && status == 'acknowledged'
    end


    def cant_accept_if_match_closed
      if save_will_accept? && match.closed
        then errors.add :status, "This match has already been closed."
      end
    end

    def cant_accept_if_client_has_related_active_match
      if save_will_accept? && match.client_related_matches.active.on_route(match_route).exists? && ! match_route.allow_multiple_active_matches
        then errors.add :status, "There is already another active match for this client"
      end
    end

    def cant_accept_if_opportunity_has_related_active_match
      if save_will_accept? && match.opportunity_related_matches.active.any? && ! match_route.allow_multiple_active_matches
      then errors.add :status, "There is already another active match for this opportunity"
      end
    end

    private def ensure_required_contacts_present_on_accept
      missing_contacts = []
      if save_will_accept? && match.dnd_staff_contacts.none?
        missing_contacts << "a #{_('DND')} Staff Contact"
      end

      if save_will_accept? && match.housing_subsidy_admin_contacts.none?
        missing_contacts << "a #{_('Housing Subsidy Administrator')} Contact"
      end

      if missing_contacts.any?
        errors.add :match_contacts, "needs #{missing_contacts.to_sentence}"
      end
    end

  end

end
