class AddCollectorToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :collector, :integer
  end
end
