class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.text :token
      t.string :user
      t.string :winner
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
