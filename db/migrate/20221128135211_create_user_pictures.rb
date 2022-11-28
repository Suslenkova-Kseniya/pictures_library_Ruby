class CreateUserPictures < ActiveRecord::Migration[7.0]
  def change
    create_table :user_pictures do |t|
      t.integer :user_id
      t.integer :picture_id
      t.boolean :icon, default: false
      t.timestamps
    end
  end
end
