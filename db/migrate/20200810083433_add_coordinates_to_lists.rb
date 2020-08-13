class AddCoordinatesToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :latitude, :float
    add_column :lists, :longitude, :float
  end
end
