class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    #microposts returned newest first
    add_index :microposts, [:user_id, :created_at]
  end
end
