class Test
  include Mongoid::Document

  field :test_for, type: String
  field :result, type: String
  field :remark, type: String

  embedded_in :report, inverse_of: :tests
end
