class SearchController < ApplicationController
	
	include GetRequest

	def perform

		query = params[:query]
		
		responses = $redis.get(query)

    if responses.nil?
    	puts message = "Request is being processed and results will be available shortly."
      worker = ApiRequestWorker.new
      worker.perform query
    else
    	# Pain, gore and glory.
    	# Without the gsub parsing leads to this error:
    	# JSON::ParserError: 451: unexpected token at '{
    	responses = JSON.parse responses.gsub('=>', ':')
      @responses = responses

      respond_to do |format|
        format.js { render 'results.js' }
      end
    end
    
    



	end

end
