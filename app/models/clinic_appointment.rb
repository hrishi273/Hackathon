class ClinicAppointment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date

  belongs_to :patient
  belongs_to :doctor
end
