class AdminController < ApplicationController
	before_action :authenticate_user!
	def index

	end

	def create_user
	end

	def create_user_post
		@fname = params[:user][:fullname]
		@uname = params[:user][:username]
		@role = params[:user][:role]
		@password = params[:user][:password]

		@user = User.create(fullname: @fname.to_s,username: @uname.to_s,email: "",role: @role.to_s,password: @password.to_s,password_confirmation: @password.to_s)
		if @role == "Patient"
			@patient = Patient.create(name:@user.fullname,user_id: @user._id)
		elsif @role == "Lab Manger"
			@lab = Lab.create(name: @fname,user_id: @user._id)
		else
			@doctor = Doctor.create(name: @fname,user_id: @user._id)	
		end

		redirect_to create_user_path,alert:"User Successfully created!" 
	end

	def manage_users
		@users = User.all.order("username ASC").page(params[:page]).per(10)
	end
end
