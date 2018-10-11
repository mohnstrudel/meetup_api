module GetRequest
	def self.perform_search(query)
		connection = Faraday.new "https://api.meetup.com" do |conn|
  		conn.response :json, :content_type => /\bjson$/
			conn.adapter Faraday.default_adapter
		end
		json_response = connection.get("find/groups?key=#{Figaro.env.meetup_api_key}&sign=true&location=munich&text=#{query}")
		json_response.body
	end
end