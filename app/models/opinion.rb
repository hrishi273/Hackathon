class Opinion
  include Mongoid::Document

  field :patient_id, type: String
  field :report_id
  field :opinion_text, type: String

  belongs_to :doctor
end
