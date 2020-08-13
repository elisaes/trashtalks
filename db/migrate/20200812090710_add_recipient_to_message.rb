class AddRecipientToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :recipient, null: true, references: :users
  end
end
