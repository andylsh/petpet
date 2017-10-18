class AddStaffIdToPets < ActiveRecord::Migration[5.0]
  def change
  	add_column :pets, :staff_id, :integer
  end
end
