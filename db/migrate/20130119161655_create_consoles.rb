class CreateConsoles < ActiveRecord::Migration
  def change
    create_table :consoles do |t|
      t.string :title
      t.string :image_url
      t.timestamps
    end
  end
end
