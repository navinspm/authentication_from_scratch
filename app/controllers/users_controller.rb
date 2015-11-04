class UsersController < ApplicationController
  
  def index
  end
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(user_params)
    	if @user.save 
    		redirect_to root_url, :notice => "Sign up succesfully, You can now Login"
    	else
    		render "new"
    	end	
  end

  private
   def user_params
      params.require(:user).permit(:user_name, :password_hash, :password_salt,:password , :password_confirmation)
    end
end
