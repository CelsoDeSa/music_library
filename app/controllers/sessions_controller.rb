class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if logged_in?
      redirect_to '/albums'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/albums'
    else
       redirect_to '/login'
       flash[:alert] = "Sorry, we couldn't find an account with this username. Please check you're using the right username and try again."
    end
  end

  def login
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
    
end
