class PetsController < ApplicationController

	def index
		@pets = Pet.all.check_role(session[:current_user_id])
	end

	def new
		@pet = Pet.new
		response = RestClient.get("https://dog.ceo/api/breeds/image/random")
		@dogs = JSON.parse(response.body)

	end

	def create
		@user = User.find(session[:current_user_id])
		@pet = Pet.new(pet_params)
		if @user.role == "animal_shelter"
			if @user.animal_shelter_id.nil?
				flash[:failure] = "Sorry, you must register your company id"
				redirect_to pets_path
			else
				if @pet.valid?
					Pet.all.each do |pet|
						if pet.name == @pet.name 
							# if pet.pet_type == @pet.pet_type 
								if pet.animal_shelter.company_name == @user.animal_shelter.company_name
									flash[:failure] = "Sorry someone added the pet"
									redirect_to new_pet_path 
								else
									if @pet.pet_type == "dog"
										@pet.save
										flash[:success] = "Added dog"
										redirect_to pets_path
									else
										@pet.photo = "http://placehold.it/200x200/EEE"
										@pet.save
										flash[:success] = "Added cat"
										redirect_to pets_path
									end
								# end
							end
						end
					end
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

	def update
		@pet = Pet.find(params[:id])
		if @pet.update(verification: true, user_id: session[:current_user_id])
			redirect_to pets_path
		end
	end

	def destroy
		@pet = Pet.find(params[:id])
		@user = User.find(session[:current_user_id])
		if @user.role == "animal_shelter"
			if @pet.staff_id == @user.id && @pet.animal_shelter.company_name == @user.animal_shelter.company_name
				@pet.destroy
				flash[:success] = "Removed successfully"
 				redirect_to pets_path
 			else
 				flash[:failed] = "You do not have the authorization"
 				redirect_to pets_path
 			end
		end
	end

	private
	def pet_params
		params.require(:pet).permit(:name, :age_year, :age_month, :description, :pet_type, :animal_shelter_id, :staff_id, :photo)
	end
end
