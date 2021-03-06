require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "validations" do

    it "should have first_name, last_name, phone_number, address1, address2, city, state, postcode, email, password_digest, role, animal_shelter_id" do
      should have_db_column(:first_name).of_type(:string)
      should have_db_column(:last_name).of_type(:string)
      should have_db_column(:phone_number).of_type(:string)
      should have_db_column(:address1).of_type(:string)
      should have_db_column(:address2).of_type(:string)
      should have_db_column(:city).of_type(:string)
      should have_db_column(:state).of_type(:string)
      should have_db_column(:postcode).of_type(:integer)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:password_digest).of_type(:string)
      should have_db_column(:role).of_type(:integer)
      should have_db_column(:animal_shelter_id).of_type(:integer)
    end

    describe "validate has secure password" do
    	it { is_expected.to have_secure_password }
    end

    describe "validates first_name" do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_length_of(:first_name).is_at_least(2).with_message(/Minimum characters is 2/)}
      it { is_expected.to validate_length_of(:first_name).is_at_most(15).with_message(/Maximum characters is 15/)}
    end

    describe "validates last_name" do
    	it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_length_of(:last_name).is_at_least(2).with_message(/Minimum characters is 2/)}
      it { is_expected.to validate_length_of(:last_name).is_at_most(15).with_message(/Maximum characters is 15/)}
    end

    describe "validates phone_number" do
      it { is_expected.to validate_numericality_of(:phone_number) }
    	it { is_expected.to validate_presence_of(:phone_number) }
    end

  	describe "validates address1, city, state, postcode" do
    	it { is_expected.to validate_presence_of(:address1) }
    	it { is_expected.to validate_presence_of(:city) }
    	it { is_expected.to validate_presence_of(:state) }
    	it { is_expected.to validate_presence_of(:postcode) }
    	it { is_expected.to validate_numericality_of(:postcode) }
    end    

    describe "validates presence and uniqueness of email" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).with_message(/email has already been taken/) }
    end

    describe "validates password" do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(4).with_message(/Minimum characters is 4/) }
      it { is_expected.to validate_length_of(:password).is_at_most(8).with_message(/Maximum characters is 8/) }
      it { is_expected.to validate_confirmation_of(:password) }
    end

    describe "validates role" do 
    	it { is_expected.to validate_presence_of(:role) }
    	it { is_expected.to define_enum_for(:role) }
     end	

    context "validates associations" do 
   		it { is_expected.to have_many(:pets) }
   		it { is_expected.to belong_to(:animal_shelter) }
    end	

    # happy_path
    describe "can be created when all attributes are present" do
      When(:user) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
      )}
      Then { user.valid? == true }
    end

    describe "can be created when all attributes are present except address2" do
      When(:user) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
      )}
      Then { user.valid? == true }
    end

    describe "can be created when all attributes are present if role is animal_shelter" do
      When(:user) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "animal_shelter"
      )}
      Then { user.valid? == true }
    end

     # unhappy_path
    describe "cannot be created without a first_name" do
      When(:user) { User.create(
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a last_name" do
      When(:user) { User.create(
      	first_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a phone_number" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without an address1" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a city" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a state" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a postcode" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a email" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end


     describe "cannot be created without a password" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password_confirmation: "123456",
        role: "normal_user" 
        )}
      Then { user.valid? == false }
    end

    describe "cannot be created without a password_confirmation" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        role: "normal_user" 
        )}
       Then { user.valid? == true }
    end

    describe "can be created as role is default value" do
      When(:user) { User.create(
      	first_name: "Raz",
      	last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      Then { user.valid? == true }
    end


    describe "should permit valid email only" do
      let(:user1) { User.create(
		    first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
      	)}
      let(:user2) { User.create(
		    first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz123.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
      	)}
      # happy_path
      it "sign up with valid email" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid email" do
        expect(user2).to be_invalid
      end
    end


    describe "should permit valid phone_number only" do
      let(:user1) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      let(:user2) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "abcabcabca",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz123.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      # happy_path
      it "sign up with valid phone_number" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid phone_number" do
        expect(user2).to be_invalid
      end
    end

    describe "should permit valid city only" do
      let(:user1) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      let(:user2) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "abcabcabca",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: " 1234",
        state: "Selangor",
        postcode: "12345",
        email: "raz123.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      # happy_path
      it "sign up with valid city" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid city" do
        expect(user2).to be_invalid
      end
    end

    describe "should permit valid state only" do
      let(:user1) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      let(:user2) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "abcabcabca",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "1234",
        postcode: "12345",
        email: "raz123.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      # happy_path
      it "sign up with valid state" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid state" do
        expect(user2).to be_invalid
      end
    end

    describe "should permit valid postocde only" do
      let(:user1) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "0123456789",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "12345",
        email: "raz@nextacademy.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      let(:user2) { User.create(
        first_name: "Raz",
        last_name: "Raz",
        phone_number: "abcabcabca",
        address1: "1 Jalan Mewah",
        address2: "Mewah",
        city: "Mewah City",
        state: "Selangor",
        postcode: "abcde",
        email: "raz123.com",
        password: "123456",
        password_confirmation: "123456",
        role: "normal_user"
        )}
      # happy_path
      it "sign up with valid postocde" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid postcode" do
        expect(user2).to be_invalid
      end
    end

    #happy_path
    describe User do
      let(:first_name) { "Raz" }
      let(:last_name) { "Raz" }
      
    describe "full_name will generate" do
      it "will return the first name and last name" do
        user = User.create(first_name: first_name, last_name: last_name)
        result = user.full_name
        expect(result).to eq("Raz Raz")
      end
    end
    end
  end
end

    

