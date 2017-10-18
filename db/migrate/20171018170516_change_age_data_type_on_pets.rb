class ChangeAgeDataTypeOnPets < ActiveRecord::Migration[5.0]
  def up
    change_column :pets, :age_year , 'integer USING CAST(age_year AS integer)'
    change_column :pets, :age_month, 'integer USING CAST(age_month AS integer)'
  end

  def down
    change_column :pets, :age_year, :string
    change_column :pets, :age_month, :string
  end

end
