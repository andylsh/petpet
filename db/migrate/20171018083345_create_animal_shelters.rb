class CreateAnimalShelters < ActiveRecord::Migration[5.0]
  def change
    create_table :animal_shelters do |t|
      t.string   :company_name
      t.string   :office_number
      t.string   :company_address1
      t.string   :company_address2
      t.string   :city
      t.string   :state
      t.integer  :postcode
      
      t.timestamps
    end
  end
end
