class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.text :content
      t.integer :user_id
      t.datetime :by_when
      t.string :completed
      t.timestamps null: false
    end
  end
end
