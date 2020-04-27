class PatientBroadcastJob < ApplicationJob  
  queue_as :default  

  def perform(patient)  
    ActionCable.server.broadcast 'patient_channel', item: render(patient)  
  end  

  private   
    def render(patient)  
        ApplicationController.renderer.render(partial: 'patients/patient', locals: {patient: patient})  
    end  
end