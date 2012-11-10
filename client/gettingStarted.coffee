#------ INITIALIZERS -----
apiKey = '< API KEY GOES HERE>'
sessionId = '< SessionId Goes Here >'
token = '< Token Goes Here >'
publisherElement = "< Publisher Element to Replace with video >"
subscriberContainer = "< Subscriber Container to contain all the subscribed videos >"
# End of Initializers

# Code:
TB.setLogLevel(TB.DEBUG)

session = TB.initSession(sessionId)
session.addEventListener('sessionConnected', sessionConnectedHandler)
session.addEventListener('streamCreated', streamCreatedHandler)
session.connect(apiKey, token)

publisher = ""

sessionConnectedHandler = (event) ->
  publisher = TB.initPublisher(apiKey, publisherElement)
  session.publish(publisher)
  # Subscribe to streams that were in the session when we connected
  subscribeToStreams(event.streams)

streamCreatedHandler = (event) ->
  # Subscribe to any new streams that are created
  subscribeToStreams(event.streams)

subscribeToStreams (streams) ->
  for stream in streams
    if stream.connection.connectionId == session.connection.connectionId
      return
    # Create the div to put the subscriber element in to
    div = document.createElement('div')
    div.setAttribute('id', 'stream' + streams[i].streamId)
    document.getElementById( subscriberContainer ).appendChild(div)

    # Subscribe to the stream
    subscribeProps = {height:240, width:320}
    session.subscribe(streams[i], div.id)
