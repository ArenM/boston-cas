class AddDoToMatchContacts < ActiveRecord::Migration[4.2]
  def change
    add_column :client_opportunity_match_contacts, :do, :boolean, default: false, null: false
    add_column :program_contacts, :do, :boolean, default: false, null: false
  end
end
