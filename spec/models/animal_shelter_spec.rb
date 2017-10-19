require 'rails_helper'

RSpec.describe AnimalShelter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  context "validations" do

    it "should have company_name, office_number, company_address1, company_address2, city, state, postcode and created_by" do
      should have_db_column(:company_name).of_type(:string)
      should have_db_column(:office_number).of_type(:string)
      should have_db_column(:company_address1).of_type(:string)
      should have_db_column(:company_address2).of_type(:string)
      should have_db_column(:city).of_type(:string)
      should have_db_column(:state).of_type(:string)
      should have_db_column(:postcode).of_type(:integer)
      should have_db_column(:created_by).of_type(:string)
    end

    describe "validates presence of company_name and uniqueness " do
      it { is_expected.to validate_presence_of(:company_name) }
      it { is_expected.to validate_uniqueness_of(:company_name).with_message(/Company already exist/) }
    end

    describe "validates office_number" do
      it { is_expected.to validate_presence_of(:office_number) }
      it { is_expected.to validate_numericality_of(:office_number) }
    end

    describe "validates company_address1" do
      it { is_expected.to validate_presence_of(:company_address1) }
    end


  describe "validates city" do
      it { is_expected.to validate_presence_of(:city) }
    end 
  
  describe "validates state" do
      it { is_expected.to validate_presence_of(:state) }
    end

    describe "validates postcode" do
      it { is_expected.to validate_presence_of(:postcode) }
      it { is_expected.to validate_numericality_of(:postcode) }
    end

    describe "validates created_by" do
      it { is_expected.to validate_presence_of(:created_by) }
    end

    context "validates associations" do 
      it { is_expected.to have_many(:users) }
      it { is_expected.to have_many(:pets).dependent(:destroy) }
    end 

    # happy_path
    describe "can be created when all attributes are present" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah",
        company_address2: "Mewah Jaya",
        city: "Mewah",
        state: "KL",
        postcode: "57100",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == true }
    end

    describe "can be created when all attributes are present except company_address2" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah",
        city: "Mewah",
        state: "KL",
        postcode: "57100",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == true }
    end

     # unhappy_path
    describe "cannot be created without a company_name" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah",
        city: "Mewah",
        state: "KL",
        postcode: "57100",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == false }
    end

    describe "cannot be created without a office_number" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        company_address1: "12 Jalan Mewah",
        city: "Mewah",
        state: "KL",
        postcode: "57100",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == false }
    end

    describe "cannot be created without a company_address1" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        city: "Mewah",
        state: "KL",
        postcode: "57100",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == false }
    end

    describe "cannot be created without a city" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah",
        state: "KL",
        postcode: "57100",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == false }
    end

    describe "cannot be created without a state" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah",
        city: "Mewah",
        postcode: "57100",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == false }
    end

    describe "cannot be created without a postcode" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah",
        city: "Mewah",
        state: "KL",
        created_by: user.full_name
      )}
      Then { animal_shelter.valid? == false }
    end

    describe "cannot be created without a created_by" do
      When(:animal_shelter) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah",
        city: "Mewah",
        state: "KL",
        postcode: "57100",
      )}
      Then { animal_shelter.valid? == false }
    end

    describe "should permit valid office_number only" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      let(:company1) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "Mewah", 
        state: "KL", 
        postcode: "57100",
        created_by: user.full_name
        )}
      let(:company2) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "abcabcacbca",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "Mewah", 
        state: "KL", 
        postcode: "57100",
        created_by: user.full_name
        )}
      # happy_path
      it "sign up with valid office_number" do
        expect(company1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid office_number" do
        expect(company2).to be_invalid
      end
    end

    describe "should permit valid city only" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      let(:company1) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "Mewah", 
        state: "KL", 
        postcode: "57100",
        created_by: user.full_name
        )}
      let(:company2) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "12345", 
        state: "KL", 
        postcode: "57100",
        created_by: user.full_name
        )}
      # happy_path
      it "sign up with valid city" do
        expect(company1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid city" do
        expect(company2).to be_invalid
      end
    end

    describe "should permit valid state only" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      let(:company1) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "Mewah", 
        state: "KL", 
        postcode: "57100",
        created_by: user.full_name
        )}
      let(:company2) { AnimalShelter.create(
        company_name: "Woof",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "Mewah", 
        state: "12345", 
        postcode: "57100",
        created_by: user.full_name
        )}
      # happy_path
      it "sign up with valid state" do
        expect(company1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid state" do
        expect(company2).to be_invalid
      end
    end

    describe "should permit valid postocde only" do
      let(:user) { User.create(first_name: "Raz" ,last_name: "Raz",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "raz@gmail.com", password: "password", password_confirmation: "password" ,role: 0 ) }
      let(:company1) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "Mewah", 
        state: "KL", 
        postcode: "57100",
        created_by: user.full_name
        )}
      let(:company2) { AnimalShelter.create(
        company_name: "Meow",
        office_number: "0123456789",
        company_address1: "12 Jalan Mewah", 
        company_address2: "Mewah Jaya", 
        city: "Mewah", 
        state: "KL", 
        postcode: "abcde",
        created_by: user.full_name
        )}
      # happy_path
      it "sign up with valid postocde" do
        expect(company1).to be_valid
      end

      # unhappy_path
      it "sign up with invalid postcode" do
        expect(company2).to be_invalid
      end
    end

    #happy_path
    describe User do
      let(:animal_shelter1) { AnimalShelter.create(company_name: "Meow",office_number: "0123456789" ,company_address1: "12 Jalan Mewah", company_address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100") }
    describe "search" do
      it "it equal to search argument" do
        result = AnimalShelter.company_search(company_name: "animal_shelter1.company_name")
        expect(result).to eq(AnimalShelter.company_name("animal_shelter1.company_name"))
      end

      it "it return all if search argument empty" do
        result = AnimalShelter.company_search(company_name: "")
        expect(result).to eq(AnimalShelter.company_name(""))
      end

      it "it return all if wrong search argument" do
        result = AnimalShelter.company_search(company_name: "woof")
        expect(result).to eq(AnimalShelter.company_name("woof"))
      end
    end
    describe "location will generate" do
      it "will return the full address" do
        company = AnimalShelter.create(company_address1: "aaaa", company_address2: "aaaa", city: "aaaa", state: "Johor", postcode: 11111)
        result = company.location
        expect(result).to eq("aaaa, aaaa, aaaa, Johor, 11111")
      end
    end
    end

    end

end