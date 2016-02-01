class PatientsController < ApplicationController
  before_action :set_patient, only:[:show,:edit,:update,:destroy,:see_report,:ask_opinion,:book_appointment,:save_appointment,:check_appointments,:see_reports,:see_report_post]
  before_action :authenticate_user!
  # GET /patients
  # GET /patients.json
  def index
    @patient = Patient.where(name: current_user.fullname).first
    redirect_to patient_path(@patient.name)
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @reports = @patient.reports.order("created_at DESC").page(params[:page]).per(3)
  end

  # GET /patients/new
  def new
    @patient = Patient.new
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
        format.html { redirect_to patient_path(@patient.name), notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: patient_path(@patient.name) }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    puts @patient.name
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_path(@patient.name), notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: patient_path(@patient.name) }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def see_report
    @report = Report.find(params[:id])
    @treatment = Treatment.where(report_id: @report._id).first
    @opinions = Opinion.where(patient_id: @patient._id,report_id: @report._id)
  end

  def see_report_post
    @report = Report.find(params[:id])
    @treatment = Treatment.where(report_id: @report._id).first
    @doc1 = Doctor.find(params[:opinion][:doctor1])
    @doc2 = Doctor.find(params[:opinion][:doctor2])
    @doc1.requests.create(content:"Patient wants your opinion on a report.",patient_id: @patient._id,report_id: @report._id)
    @doc2.requests.create(content:"Patient wants your opinion on a report.",patient_id: @patient._id,report_id: @report._id)
    redirect_to see_report_path(@patient.name,@report), notice: "Request was sent" 
  end

  def book_appointment
    @labs = Lab.all
    @appointment = Appointment.new
  end

  def save_appointment
    @appointment = Appointment.new(appointment_params)
    @appointment.patient_id = @patient._id
    if @appointment.save
      redirect_to patient_path(@patient.name), notice:"Appointment successfully booked!"
    else
      render "book_appointment", notice:"Something went wrong! Please resolve issue before proceeding!"
    end
  end

  def check_appointments
    @appointments = Appointment.where(patient_id: @patient.id).page(params[:page]).per(5)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.where(name: params[:name]).first()
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :address, :contact, :email, :date_of_birth, :blood_group, :height, :weight)
    end

    def appointment_params
      params.require(:appointment).permit(:date,:patient_id,:lab_id)
    end
end
