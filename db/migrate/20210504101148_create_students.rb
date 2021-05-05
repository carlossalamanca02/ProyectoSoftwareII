class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :carrer
      t.string :email
      t.timestamps
    end
  end
end
