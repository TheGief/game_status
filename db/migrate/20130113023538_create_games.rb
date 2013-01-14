class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :image_url

      t.timestamps
    end

    add_index :games, :title
  end
end
