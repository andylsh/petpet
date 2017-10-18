class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :age_year
      t.string :age_month
      t.text :description
      t.string  :pet_type
      t.string :photo
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :animal_shelter, index:true , foreign_key: true

      t.timestamps
    end
  end
end
