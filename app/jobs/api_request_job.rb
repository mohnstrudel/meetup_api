class ApiRequestJob < ApplicationJob
  queue_as :low

  def perform(*args)
  end
end
