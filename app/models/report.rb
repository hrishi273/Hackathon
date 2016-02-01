class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :date, type: Date

  belongs_to :patient
  embeds_many :tests
  
  accepts_nested_attributes_for :tests,allow_destroy: true
  
  has_many :treatments
end
