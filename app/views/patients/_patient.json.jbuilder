json.extract! patient, :id, :score, :severity, :pulse, :age, :respiratory, :created_at, :updated_at
json.url patient_url(patient, format: :json)
