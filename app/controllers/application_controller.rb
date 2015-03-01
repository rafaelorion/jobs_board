class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private 
  def current_company
  	@current_company ||= if session[:company_id]
  		Company.find_by_id(session[:company_id])
  	end 
  end

  helper_method :current_company 
end
