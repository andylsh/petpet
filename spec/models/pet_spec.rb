require 'rails_helper'

RSpec.describe Pet, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "validations" do

    it "should have name, age_year, age_month, description, pet_type, photo, user_id, animal_shelter_id, staff_id, and verification" do
      should have_db_column(:name).of_type(:string)
      should have_db_column(:age_year).of_type(:integer)
      should have_db_column(:age_month).of_type(:integer)
      should have_db_column(:description).of_type(:text)
      should have_db_column(:photo).of_type(:string)
      should have_db_column(:user_id).of_type(:integer)
      should have_db_column(:animal_shelter_id).of_type(:integer)
      should have_db_column(:staff_id).of_type(:integer)
      should have_db_column(:verification).of_type(:boolean)
    end

    describe "validates name" do
    	it { is_expected.to validate_presence_of(:name) }
    	it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(8) }
    end

    describe "validates age_year" do
    	it { is_expected.to validate_presence_of(:age_year) }
    	it { is_expected.to validate_numericality_of(:age_year) }
    end

    describe "validates age_month" do
    	it { is_expected.to validate_presence_of(:age_month) }
    	it { is_expected.to validate_numericality_of(:age_month) }
    end


	describe "validates description" do
    	it { is_expected.to validate_presence_of(:description) }
    	it { is_expected.to validate_length_of(:description).is_at_least(2).is_at_most(15) }
    end 
 	
 	describe "validates pet_type" do
    	it { is_expected.to validate_presence_of(:pet_type) }
    end  

    describe "validates pet_type" do
    	it { is_expected.to validate_presence_of(:verification) }
    end   

    context "validates associations" do 
    	it { is_expected.to belong_to(:user) }
   		it { is_expected.to belong_to(:staff) }
   		it { is_expected.to belong_to(:animal_shelter) }
    end	

    # happy_path
    describe "can be created when all attributes are present" do
      When(:pet) { Pet.create(
        name: "Ali",
        age_year: "2",
        age_month: "3",
        description: "Very cute",
        pet_type: "dog",
        verification: "false",
      )}
      Then { user.valid? == true }
    end

     # unhappy_path
    describe "cannot be created without a name" do
      When(:pet) { Pet.create(
        age_year: "2",
        age_month: "3",
        description: "Very cute",
        pet_type: "dog",
        verification: "false",
      )}
      Then { user.valid? == false }
    end

    describe "cannot be created without an age_year" do
      When(:pet) { Pet.create(
        name: "Ali",
        age_year: "2",
        age_month: "3",
        description: "Very cute",
        pet_type: "dog",
        verification: "false",
      )}
      Then { user.valid? == false }
    end


    describe "cannot be created without an age_month" do
      When(:pet) { Pet.create(
        name: "Ali",
        age_year: "2",
        description: "Very cute",
        pet_type: "dog",
        verification: "false",
      )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a description" do
      When(:pet) { Pet.create(
        name: "Ali",
        age_year: "2",
        age_month: "3",
        pet_type: "dog",
        verification: "false",
      )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a pet_type" do
      When(:pet) { Pet.create(
        name: "Ali",
        age_year: "2",
        age_month: "3",
        description: "Very cute",
        verification: "false",
      )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a verification" do
      When(:user) { User.create(
      	When(:pet) { Pet.create(
        name: "Ali",
        age_year: "2",
        age_month: "3",
        description: "Very cute",
        pet_type: "dog",
        verification: "false",
       )}
      Then { user.valid? == false }
    end

    describe "will check role" do
      it "will return pets that haven't been adopt to normal user" do
        result = Pet.check_role(session[:current_user_id])

      end
      it "will return all the pets that have been adopted and haven't been adopt to admin and animal_shelter" do

      end
    end
  end

end