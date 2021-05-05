class CreateElements < ActiveRecord::Migration[6.1]
  def change
    create_table :elements do |t|
      t.string :name 
      t.string :description
      t.integer :quantity
      t.integer :avaliable
      t.timestamps
    end
  end
end
