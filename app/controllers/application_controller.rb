class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	add_flash_types :alert, :error;

	protected
	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:id,:name,:lastname,:job_name ,:email, :password) }
	end

	helper_method :InstructorActual

 

end
