class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect_to '/welcome'
    else
       redirect_to '/login'
       flash[:alert] = "Sorry, we couldn't find an account with this username. Please check you're using the right username and try again."
    end
  end

  def login
  end

  def welcome
  end
end
