class Patient < ApplicationRecord
  after_create_commit { PatientBroadcastJob.perform_later self }  
  after_update_commit { PatientBroadcastJob.perform_later self }  
  after_destroy { PatientBroadcastJob.perform_later self }  
end
