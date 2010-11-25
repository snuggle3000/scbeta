class ApplicationController < ActionController::Base
  protect_from_forgery
  
	protected
		#Returns the currently logged in user or nil
		def current_user
			return unless session[:user_id]
			@current_user ||= User.find_by_id(session[:user_id])
		end
		
		#Make current_user available in templates
		helper_method :current_user
		
		def authenticate
			logged_in? ? true : access_denied
		end
		
		def logged_in?
			current_user.is_a? User
		end
		
		helper_method :logged_in?

		def access_denied
			redirect_to login_path, :notice => "Please log in" and return false
		end
end
