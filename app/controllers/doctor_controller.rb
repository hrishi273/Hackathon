class DoctorController < ApplicationController
	before_action :authenticate_user!
	before_action :set_doctor
	
	def index
	end

	def edit
	end

	def update
		if @doctor.update(doctor_params)
			redirect_to show_profile_path, notice:"Profile Successfully Updated!"
		else
			render "edit"
		end
	end

	def show
	end

	def patient_info
		@patients = Patient.all.order("name ASC").page(params[:page]).per(10)
	end

	def show_patient
		@patient = Patient.where(name: params[:name]).first
		@reports = Report.where(patient_id: @patient._id).order("date DESC").page(params[:page]).per(3)
	end

	def check_opinion_requests
		@requests = @doctor.requests.order("created_at ASC").page(params[:page]).per(5)
	end

	def give_treatment
		@patient = Patient.where(name: params[:name]).first
		@report = Report.find(params[:id])
		@treatment = Treatment.new
	end

	def give_treatment_post
		@patient = Patient.where(name: params[:name]).first
		@report = Report.find(params[:id])
		@treatment = Treatment.create(treatment_params)
		@treatment.report_id = @report._id
		@treatment.save
		redirect_to show_d_patient_path(@patient.name),notice: "Treatment Successfully Prescribed!"
	end

	def give_opinion
		@patient = Patient.where(name: params[:name]).first
		@report = Report.find(params[:id])
		@opinion = Opinion.new
	end

	def give_opinion_post
		@patient = Patient.where(name: params[:name]).first
		@report = Report.find(params[:id])
		@opinion = Opinion.create(opinion_params)
		@opinion.patient_id = @patient._id
		@opinion.report_id = @report._id
		@opinion.doctor_id = @doctor._id
		@opinion.save
		redirect_to show_d_patient_path(@patient.name),notice: "Opinion Successfully Delivered!"
	end	

	private
		def set_doctor
			@doctor = Doctor.where(user_id: current_user._id).first
		end

		def doctor_params
			params.require(:doctor).permit(:name,:degree,:specialization,:contact)
		end

		def treatment_params
			params.require(:treatment).permit(:prescription)
		end

		def opinion_params
			params.require(:opinion).permit(:opinion_text)
		end
end
