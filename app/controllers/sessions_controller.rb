class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:user_name],params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to root_url, :notice=> "Logged in"
  	else
  		flash.now.alert = "Invalid user name or password"
  		render 'new'
  	end
  end
  def destroy
  	session[:user_id] = nil
  	redirect_to root_url , :notice => "Logged out!"
  end

   private
   def session_params
      params.require(:session).permit(:user_name,:password)
    end
end
