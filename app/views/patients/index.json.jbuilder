json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :address, :contact, :date_of_birth, :blood_group, :height, :weight
  json.url patient_url(patient, format: :json)
end
