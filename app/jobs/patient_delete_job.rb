class PatientDeleteJob < ApplicationJob  
  queue_as :default  

  def perform(patient)
    patient.destroy!
  end  
end