class AddUnitLevelRuleSupports < ActiveRecord::Migration[4.2]
  def change
    add_column :project_clients, :requires_ground_floor, :boolean, default: false
    add_column :project_clients, :requires_wheelchair_accessibility, :boolean, default: false
    add_column :project_clients, :required_number_of_bedrooms, :integer, default: 1
    add_column :project_clients, :required_minimum_occupancy, :integer, default: 1

    add_column :clients, :requires_ground_floor, :boolean, default: false
    add_column :clients, :requires_wheelchair_accessibility, :boolean, default: false
    add_column :clients, :required_number_of_bedrooms, :integer, default: 1
    add_column :clients, :required_minimum_occupancy, :integer, default: 1

  end
end
