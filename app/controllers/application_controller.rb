class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
  	if current_user.role == "Patient"
  		patients_path	
  	elsif current_user.role == "Doctor"
  		doctors_path
  	elsif current_user.role == "admin"
  		admin_index_path
  	else
  		labs_path	
  	end
  end

  def after_sign_up_path_for(resource)
    if current_user.role == "Patient"
      @patient = Patient.create(fullname: current_user.name,user_id:current_user._id)
      patients_path 
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fullname,:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login,:fullname, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:fullname, :username, :email, :password, :password_confirmation, :current_password) }
    end
end
