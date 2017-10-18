class Pet < ApplicationRecord
	
	belongs_to :user, optional: true
	belongs_to :staff, class_name: "User", foreign_key: "staff_id"
	belongs_to :animal_shelter
	validates :age_year, presence: true, numericality: { only_integer: true }
	validates :age_month, presence: true, numericality: { only_integer: true }
	validates :description, presence: true, length: {in: 2..15, too_short: "Minimum characters is 2", too_long: "Maximum characters is 15"}
	validates :pet_type, presence: true

end