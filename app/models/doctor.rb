class Doctor
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :degree, type: String
  field :specialization, type: String
  field :contact, type: BigDecimal

  has_many :clinic_appointments
  embeds_many :requests
  has_many :opinions
  
  belongs_to :user
end
