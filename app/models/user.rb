class User < ApplicationRecord
	class User < ApplicationRecord::
	
	has_secure_password
	validates :first_name, presence: true, length: {in: 2..15, too_short: "Minimum characters is 2", too_long: "Maximum characters is 15"}, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed" }
	validates :last_name, presence: true, length: {in: 2..15, too_short: "Minimum characters is 2", too_long: "Maximum characters is 15"}, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed" }
	validates :phone_number, numericality: { only_integer: true }, format: {with: /\d{10}/, message: "Please enter valid phone number"}
	validates :address1, presence: true
	validates :city, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "Only letters allowed" }
	validates :state, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed"}
	validates :postcode, numericality: { only_integer: true }, format: {with: /\d{5}/, message: "Please enter a valid postcode" }
	validates :email, presence: true, uniqueness: { message: "email has already been taken" }, format: { with: /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i, multiline: true}
	validates :password, length: {in: 2..8, too_short: "Minimum characters is 2", too_long: "Maximum characters is 8"}, allow_nil: true
	validates :password_confirmation, presence: true, allow_nil: true
	validates :role, presence: true
	enum role: { normal_user: 0, animal_shelter: 1, admin: 2 }
	belongs_to :animal_shelter, optional: true
	# has_many :pets
	
end
