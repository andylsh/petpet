class AddCreatedByToAnimalShelters < ActiveRecord::Migration[5.0]
  def change
  	add_column :animal_shelters, :created_by, :string
  end
end
