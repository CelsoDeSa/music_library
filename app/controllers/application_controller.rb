class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    helper_method :current_user
    helper_method :logged_in?
    helper_method :is_admin?

    def current_user
       User.find_by(id: session[:user_id])
    end

    def logged_in?
           
        !current_user.nil?
    end    

    def is_admin?
        current_user && current_user.role == "admin" ? true : false
    end

end
