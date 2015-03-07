class JobsController < ApplicationController

  before_filter :authorize_company, only: [:new, :create, :edit, :update, :destroy]

  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.most_recent.includes(:company).all
  end

  def premium
    # @jobs = Job.where(premium: true).order("created_at DESC").all
    @jobs = Job.where(premium: true).includes(:company).order("created_at DESC").paginate(page: params[:page], per_page:3 )
  end
  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @jog = Job.find_by_slug(params[:id])
    #@jog = Job.find(params[:id])

  end

  # GET /jobs/new
  def new
    @job = current_company.jobs.build
  end

  # GET /jobs/1/edit
  def edit
    @job = current_company.jobs.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = current_company.jobs.build(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @job = current_company.jobs.find(params[:id])

    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = current_company.jobs.find(params[:id])

    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :premium, :description)
    end

    def authorize_company
      unless current_company
        redirect_to root_path, alert: "You need login to continue."
      end
    end

end
