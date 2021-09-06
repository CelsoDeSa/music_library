class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:full_name, :username, :password, :role))

    session[:user_id] = @user.id

    redirect_to '/welcome'
  end
end
