class PatientChannel < ApplicationCable::Channel
  def subscribed
    stream_from "patient_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
