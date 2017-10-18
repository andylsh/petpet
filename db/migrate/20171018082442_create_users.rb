class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :full_name
      t.string   :phone_number
      t.string   :address1
      t.string   :address2
      t.string   :city
      t.string   :state
      t.integer  :postcode
      t.string   :email
      t.string   :password_digest
      t.integer  :role,            default: 0

      t.timestamps
    end
  end
end
