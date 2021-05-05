class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.date :fecha
      t.time :Hsolicitud
      t.time :Hdevolucion
      t.references :user, null: false, foreign_key: true
      t.references :element, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.timestamps
    end
  end
end
