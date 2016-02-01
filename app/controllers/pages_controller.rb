class PagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def list_of_labs
  	@labs= Lab.all.order("name ASC").page(params[:page]).per(10)
  end

  def list_of_doctors
  	@doctors= Doctor.all.order("name ASC").page(params[:page]).per(10)
  end
end