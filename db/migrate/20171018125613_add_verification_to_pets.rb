class AddVerificationToPets < ActiveRecord::Migration[5.0]
  def change
  	add_column :pets, :verification, :boolean, default: false
  end
end
