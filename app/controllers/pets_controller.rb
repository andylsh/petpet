class PetsController < ApplicationController

	def index
		@pets = Pet.all
	end

	def new
		@pet = Pet.new
	end

	def create
		@user = User.find_by(id: session[:current_user_id])
		@pet = Pet.new(pet_params)
		if @user.role == "animal_shelter"
			if @user.animal_shelter_id.nil?
				flash[:failure] = "Sorry, you must register your company id"
			else
				if @pet.valid?
					@pet.save
					flash[:success] = "Added pets"
					redirect_to pets_path
				else
					flash[:failure] = @pet.errors.full_messages
					redirect_to new_pet_path
				end
			end
		else
			flash[:failure] = "Sorry, you must register your company id"
			redirect_to root_path
		end
	end

	private
	def pet_params
		params.require(:pet).permit(:name, :age_year, :age_month, :description, :pet_type, :animal_shelter_id, :staff_id)
	end
end