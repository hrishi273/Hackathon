class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  field :patient_id, type: String
  field :report_id
  field :content

  embedded_in :doctor,inverse_of: :requests
end
