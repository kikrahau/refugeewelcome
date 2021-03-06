class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    if params[:category_ids]
      category_ids = params[:category_ids].reject(&:blank?)
      @categories = Category.find category_ids
    else
      category_ids = []
      @categories = []
    end
    session[:return_to] ||= request.url
    encode_location
    @jobs = Job.filter(category_ids, @city)
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

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
      params.require(:job).permit(:title, :text, :category_ids)
    end   

    def encode_location
      @location = CityDistrict.find_by(zip: session[:location])
      unless params[:location].blank?
        if params[:location].is_numeric?
          @location = CityDistrict.find_by(zip: params[:location])
        else
          @location = CityDistrict.find_by('name ILIKE ?', "%#{params[:location].downcase}%")
        end

        if params[:location] && @location.blank? 
          flash[:error] = 'Stadt wurde nicht gefunden, versuchen Sie es erneut' 
        else 
          session[:location] = @location.zip
        end
      end
    end 
end
