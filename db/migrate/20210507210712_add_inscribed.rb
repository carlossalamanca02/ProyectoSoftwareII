class AddInscribed < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :inscribed, :integer
  end
end
