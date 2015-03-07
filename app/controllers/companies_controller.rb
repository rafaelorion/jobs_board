class CompaniesController < ApplicationController
	def new
		@company = Company.new
	end

	def create
		@company = Company.new(company_params)

		if @company.save
			redirect_to root_path, notice: "Company was successfuly saved."
		else
			render "new"
		end
	end

	def company_params
      params.require(:company).permit(:name, :email, :password, :password_confirmation)
    end

    def show
    	@company=Company.find(params[:id])
    	#render xml: @company, except:  ['encrypted_password'], include: [:jobs]
    	render json: @company, except:  ['encrypted_password'], include: [:jobs]
    end
end