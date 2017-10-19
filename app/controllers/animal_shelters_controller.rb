class AnimalSheltersController < ApplicationController

	def index
		@companies = AnimalShelter.all
		@user = User.new
	end

	def search
		@user = User.new
		@companies = AnimalShelter.company_search(company_name: search_company_params[:company_name])
    	render 'index'
	end

	def add_id
		@user = User.find_by(id: session[:current_user_id])
		if @user.animal_shelter_id.nil?
			@user.update(animal_shelter_id: params[:add_id][:animal_shelter_id])
			redirect_to root_path
		else
			flash[:failure]= "You have company id"
			redirect_to animal_shelters_path
		end
	end

	def new
		@company = AnimalShelter.new
	end

	def create
		@user = User.find(session[:current_user_id])
		@company = AnimalShelter.new(company_params)
		if @company.valid?
			if @user.animal_shelter_id.nil?
				@company.save
				@user.animal_shelter_id = @company.id
				@user.save
				flash[:success]= "Added company"
				respond_to do |format|
					format.html { redirect_to animal_shelters_path}
					format.js
				end
				# redirect_to animal_shelters_path
			else
				flash[:failure]= "You have company id"
				# redirect_to animal_shelters_path
				respond_to do |format|
					format.html { redirect_to animal_shelters_path}
					format.js
				end
			end
		else
			flash[:failure]= @company.errors.full_messages
	      	# redirect_to new_animal_shelter_path
	      	respond_to do |format|
					format.html { redirect_to animal_shelters_path}
					format.js
				end
		end
	end

	private
	def company_params
		params.require(:animal_shelter).permit(:company_name,
											   :office_number,
											   :company_address1, 
											   :company_address2,
											   :city,
											   :state,
											   :postcode,
											   :created_by)
	end

	def search_company_params
		params.require(:search).permit(:company_name)
	end
end
