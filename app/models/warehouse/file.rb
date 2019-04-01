module Warehouse
  class File < Base
    # Ignore the STI bits
    self.inheritance_column = nil
    has_many :taggings, primary_key: :id, foreign_key: :taggable_id
    scope :for_client, lambda { |warehouse_client_id|
      where(
        type: 'GrdaWarehouse::ClientFile',
        visible_in_window: true,
        client_id: warehouse_client_id,
      )
    }
  end
end
