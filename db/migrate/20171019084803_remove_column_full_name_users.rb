class RemoveColumnFullNameUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :full_name
  end
end
