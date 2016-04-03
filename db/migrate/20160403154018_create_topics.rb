class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :string
      t.boolean :public, default: true
      t.text :description

      t.timestamps null: false
    end
  end
end
