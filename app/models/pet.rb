class Pet < ApplicationRecord
	
	belongs_to :user, optional: true
	belongs_to :staff, class_name: "User", foreign_key: "staff_id"
	belongs_to :animal_shelter
	validates :name , presence: true, length: {in: 2..8, too_short: "Minimum characters is 2", too_long: "Maximum characters is 15"}
	validates :age_year, presence: true, numericality: { only_integer: true }
	validates :age_month, presence: true, numericality: { only_integer: true }
	validates :description, presence: true, length: {in: 2..15, too_short: "Minimum characters is 2", too_long: "Maximum characters is 15"}
	validates :pet_type, presence: true
	validates :verification, presence: true

	def self.check_role(user)
		check_user = User.find(user)
		if check_user.normal_user?
			Pet.where(verification: false)
		elsif check_user.animal_shelter?
			Pet.all
		else
			Pet.all
		end
	end
end