class CreateMarkers < ActiveRecord::Migration[6.0]
  def change
    create_table :markers do |t|
      t.integer :index_num
      t.string :user
      t.references :game, foreign_key: true
      t.index [:game_id, :user, :index_num], unique: true

      t.timestamps
    end
  end
end
