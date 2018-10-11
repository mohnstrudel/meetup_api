App.pulling_results = App.cable.subscriptions.create "PullingResultsChannel",
  connected: ->
  	# $('#events').prepend "Loading data"
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('data is: ')
    console.log(data)
    $('.response_container').html(data)
		