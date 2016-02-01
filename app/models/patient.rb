class Patient
  include Mongoid::Document

  field :name, type: String
  field :address, type: String
  field :contact, type: BigDecimal
  field :email, type: String
  field :date_of_birth, type: Date
  field :blood_group, type: String
  field :height, type: Float
  field :weight, type: Float

  index ({ name:1 })

  has_many :reports
  has_many :appointments
  has_many :clinic_appointments
  
  belongs_to :user
end
