class PatientSimulationJob < ApplicationJob  
  queue_as :default  

  def perform(age, pulse, respiratory)  
    # score =  AI.API(age, pulse, respiratory)
    patient = Patient.create(age: age, pulse: pulse, respiratory: respiratory, score: rand(1.0..99.9))
    TimerJob.set(wait: 1.second).perform_later
    r = rand(6..14)
    PatientDeleteJob.set(wait: r.seconds).perform_later(patient)
  end  
end