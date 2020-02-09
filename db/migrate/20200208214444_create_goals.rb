class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.text :content
      t.integer :user_id
    end
  end
end
