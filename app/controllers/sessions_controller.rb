class SessionsController < ApplicationController

	 def new

	 end

	 def create
	 	user = User.find_by_email(params[:email])
	 	if user && user.authenticate(params[:password])
	 		session[:current_user_id] = user.id
	 		flash[:failure] = "Login successfully"
	 		redirect_to root_path
	 	else
	 		flash[:failure] = "Invalid email or password"
	 		render "new"
	 	end
	 end

	 def destroy
	 	session[:current_user_id] = nil
	 	redirect_to root_path
	 end
end