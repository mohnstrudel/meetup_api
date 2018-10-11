class PullingResultsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pulling_results_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
