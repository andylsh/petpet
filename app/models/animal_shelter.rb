class AnimalShelter < ApplicationRecord

	has_many :users
	has_many :pets, dependent: :destroy
	validates :company_name, presence: true, uniqueness: { message: "Company already exists" }
	validates :office_number, presence: true, numericality: { only_integer: true }, format: {with: /\d{10}/, message: "Please enter valid phone number"}
	validates :company_address1, presence: true
	validates :city, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "Only letters allowed" }
	validates :state, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed"}
	validates :postcode, presence: true, numericality: { only_integer: true }, format: {with: /\d{5}/, message: "Please enter a valid postcode" }
	validates :created_by, presence: true

	def self.company_search(company_name: nil)
        company_name(company_name)
    end

	def self.company_name(company_name)
		if company_name.present?
			where('company_name ilike ?', "%#{company_name}")
		else
			all
		end
	end

	def location
		company_address1 + ", " + company_address2 + ", " + city + ", " + state + ", " +  postcode.to_s 
	end

end