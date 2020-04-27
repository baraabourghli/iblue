class TimerJob < ApplicationJob  
  queue_as :default  

  def perform
    PatientSimulationJob.set(wait: 2.seconds).perform_later(rand(16..88),rand(10..140),rand(10..160))
  end  
end