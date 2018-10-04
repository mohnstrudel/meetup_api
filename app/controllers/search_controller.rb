class SearchController < ApplicationController
	
	before_action :set_api_key
	

	def perform

		query = params[:query]
		responses = $redis.get(query)

    if responses.nil?
      responses = get_request
      $redis.set(query, responses)
    else
    	# Pain, gore and glory.
    	# Without the gsub parsing leads to this error:
    	# JSON::ParserError: 451: unexpected token at '{
    	responses = JSON.parse responses.gsub('=>', ':')
    end
    @responses = responses

		respond_to do |format|
			format.js { render 'results.js' }
		end
	end

	def get_request
		connection = Faraday.new "https://api.meetup.com" do |conn|
  		conn.response :json, :content_type => /\bjson$/
			conn.adapter Faraday.default_adapter
		end
		json_response = connection.get("find/groups?key=#{@key}&sign=true&location=munich&text=#{params[:query]}")
		json_response.body  #=> { ... }
	end

	private

	def set_api_key
		@key = '54444957192d443e6865466c1c7d3f34'
	end
end
