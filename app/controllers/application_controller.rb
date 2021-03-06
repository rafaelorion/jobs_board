require "#{Rails.root}/lib/exceptions/slug_error.rb" 

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale


  rescue_from Exceptions::SlugError, :with => :rescue_from_slug_error
  def rescue_from_slug_error(exception)
    #render :text => "Slug error!"
    #render :text => exception.objeto.title
    redirect_to exception.objeto
  end
  
  private 
  def current_company
  	@current_company ||= if session[:company_id]
  		Company.find_by_id(session[:company_id])
  	end 
  end

  helper_method :current_company 

  def set_locale
    locale =  params[:locale] || cookies[:locale]

    if params[:locale].present? 
      I18n.locale = locale
      cookies[:locale] = { value: locale, expires: 30.days.from_now  }      
    end
  end

end
