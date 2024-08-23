class CreateSpreeDisplays < ActiveRecord::Migration[7.1]
  def change
    create_table :spree_displays do |t|
      t.string :name
      t.string :location
      t.string :screen_size

      t.timestamps
    end
  end
end
