class LabsController < ApplicationController
	before_action :set_patient, only: [:save_report]
	before_action :set_lab, only: [:check_appointments]
	before_action :authenticate_user!

	def index
		
	end

	def add_report
	 	@report = Report.new	
	end

	def save_report
		@report = Report.new(report_params)
		puts @patient.name
		respond_to do |format|
      	  if @report.save
        	format.html { redirect_to labs_path, notice: 'Report was successfully created.' }
        	format.json { render :show, status: :created, location: labs_path }
      	  else
        	format.html { render :new }
        	format.json { render json: @report.errors, status: :unprocessable_entity }
      	  end
    	end  
	end

	def patient_info
		@patients = Patient.all.order("name ASC").page(params[:page]).per(10)
	end	

	def check_appointments
		@appointments = Appointment.where(lab_id: @lab._id).order("date ASC").page(params[:page]).per(10)
	end

	def show_patient
		@patient = Patient.where(name: params[:name]).first
		@reports = Report.where(patient_id: @patient._id).page(params[:page]).per(3)
	end

	private
		def set_lab
			@lab = Lab.where(user_id: current_user._id).first()
		end

		def set_patient
			@patient = Patient.find(params[:report][:patient_id])
		end

		def lab_params
			params.require(:lab).permit(:name,:address,:contact)
		end 

		def report_params
			params.require(:report).permit(:date,:patient_id,tests_attributes:[:_id,:test_for,:result,:remark])
		end 	
end
