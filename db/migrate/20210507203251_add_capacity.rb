class AddCapacity < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :capacity, :integer
  end
end
