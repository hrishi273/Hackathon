class Treatment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :prescription, type: String

  belongs_to :report
end
