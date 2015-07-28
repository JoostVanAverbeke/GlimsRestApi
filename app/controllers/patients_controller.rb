class PatientsController < ApplicationController
  layout 'kendo_ui_application'

  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :set_page_size, only: [:index]
  before_action :set_page, only: [:index]

  # GET /patients
  # GET /patients.json
  def index
    puts "params = #{params}"
    @patients = Patient.paginate(page: @page, per_page: @page_size).order(:surname)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { patients: @patients, total: Patient.count} }
    end

  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patient }
    end
  end

  # GET /patients/new
  def new
    @patient = Patient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patient }
    end

  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render action: 'show', status: :created, location: @patient }
      else
        format.html { render action: 'new' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params[:patient].permit(:id, :surname, :first_name, :birth_date)
    end

    def set_page_size
      @page_size = (params[:pageSize] ? params[:pageSize] : 30)
    end

    def set_page
      @page = (params[:page] ? params[:page] : 1)
    end
end
