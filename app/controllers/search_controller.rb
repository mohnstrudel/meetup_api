class SearchController < ApplicationController
	
	before_action :set_api_key
	

	def perform
		# @response = Faraday.get 'https://api.meetup.com/2/events?key=ABDE12456AB2324445&group_urlname=ny-tech&sign=true'
		# @responses = Faraday.get "https://api.meetup.com/find/groups?key=#{@key}&sign=true&location=munich&text=#{params[:query]}"
		# @responses = @responses.body.force_encoding("utf-8").to_a

		connection = Faraday.new "https://api.meetup.com" do |conn|
  		conn.response :json, :content_type => /\bjson$/
			conn.adapter Faraday.default_adapter
		end
		json_response = connection.get("find/groups?key=#{@key}&sign=true&location=munich&text=#{params[:query]}")
		@responses = json_response.body  #=> { ... }

		respond_to do |format|
			format.js { render 'results.js' }
		end
	end

	def get_request
		connection = Faraday.new "https://api.meetup.com" do |conn|
  		conn.response :json, :content_type => /\bjson$/
			conn.adapter Faraday.default_adapter
		end
		json_response = connection.get('find/groups?key=#{@key}&sign=true&location=munich&text=#{params[:query]}')
		json_response.body  #=> { ... }
	end

	private

	def set_api_key
		@key = '54444957192d443e6865466c1c7d3f34'
	end
end
