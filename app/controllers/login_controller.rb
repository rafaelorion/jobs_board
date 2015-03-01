class LoginController < ApplicationController
	def new
	end

	def create
		company = Company.find_by_email(company_params[:email])

		if company && company.valid_password?(company_params[:password])
			session[:company_id] = company.id
			redirect_to root_path
		else
			flash.now[:alert] = "Invalid login or password."
			render "new"
		end
	end

	def company_params
      params.require(:company).permit(:name, :email, :password, :password_confirmation)
    end	
end