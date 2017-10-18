class AddAnimalShelterIdToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_reference :users, :animal_shelter, index: true
	add_foreign_key :users, :animal_shelters
  end
end
