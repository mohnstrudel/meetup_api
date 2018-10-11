class ApiRequestWorker
  include Sidekiq::Worker
  include GetRequest

  def perform(*args)
    puts "Performing query async"
		query = args[0]  	
		responses = $redis.get(query)
    if responses.nil?
      ActionCable.server.broadcast 'pulling_results_channel', data: render_loading
      while responses.nil?
        responses = GetRequest.perform_search(args[0])
      end
      $redis.set(query, responses)
    end


    ActionCable.server.broadcast 'pulling_results_channel', data: render_responses(responses)
  end

  private

  def render_responses(responses)
    ApplicationController.renderer.render(partial: 'search/results', locals: { responses: responses})
  end

  def render_loading
    ApplicationController.renderer.render(partial: 'search/loading')
  end
end
