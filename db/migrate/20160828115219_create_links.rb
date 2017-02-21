class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
