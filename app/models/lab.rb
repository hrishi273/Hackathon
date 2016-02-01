class Lab
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :address, type: String
  field :contact, type: BigDecimal

  has_many :patients
  has_many :appointments
  belongs_to :user
end
