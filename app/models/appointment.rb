class Appointment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date
  field :app_type, type: String

  belongs_to :patient
  belongs_to :lab
end
