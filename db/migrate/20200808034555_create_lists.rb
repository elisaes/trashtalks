class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.integer :status # 0 - unfufilled, 1 - fufilled
      t.string :remarks # comments that the user might have
      t.date :pickUpDate # the date that the user wants collector to pick up
      t.string :address # address that the user wants to pick up
      t.references :user, null: false, foreign_key: true # the owner of the list

      t.timestamps
    end
  end
end
