class UsersController < ApplicationController

	def index
	
	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.valid?
			if @user.role == "normal_user"
				@user.save
				session[:current_user_id] = @user.id
				redirect_to root_path
			elsif @user.role == "animal_shelter"
				@user.save
				session[:current_user_id] = @user.id
				redirect_to animal_shelters_path
			end
		else
		  flash[:failure]= @user.errors.full_messages
	      redirect_to new_user_path
		end
	end

	private
	def user_params
		params.require(:user).permit(:first_name, 
									 :last_name, 
									 :phone_number, 
									 :address1, 
									 :address2, 
									 :city, 
									 :state, 
									 :postcode, 
									 :email, 
									 :password, 
									 :password_confirmation,
									 :role,
									 :animal_shelter_id
									 )
	end

end