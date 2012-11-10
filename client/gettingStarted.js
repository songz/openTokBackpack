/* ------ INITIALIZERS ----- */
var apiKey = '< API KEY GOES HERE>';
var sessionId = '< SessionId Goes Here >';
var token = '< Token Goes Here >';
var publisherElement = "< Publisher Element to Replace with video >";
var subscriberContainer = "< Subscriber Container to contain all the subscribed videos >";
/* End of Initializers */

// Code:
TB.setLogLevel(TB.DEBUG);

var session = TB.initSession(sessionId);
session.addEventListener('sessionConnected', sessionConnectedHandler);
session.addEventListener('streamCreated', streamCreatedHandler);
session.connect(apiKey, token);

var publisher;

function sessionConnectedHandler(event) {
  publisher = TB.initPublisher(apiKey, publisherElement);
  session.publish(publisher);

  // Subscribe to streams that were in the session when we connected
  subscribeToStreams(event.streams);
}

function streamCreatedHandler(event) {
  // Subscribe to any new streams that are created
  subscribeToStreams(event.streams);
}

function subscribeToStreams(streams) {
  for (var i = 0; i < streams.length; i++) {
    // Make sure we don't subscribe to ourself
    if (streams[i].connection.connectionId == session.connection.connectionId) {
      return;
    }

    // Create the div to put the subscriber element in to
    var div = document.createElement('div');
    div.setAttribute('id', 'stream' + streams[i].streamId);
    document.getElementById( subscriberContainer ).appendChild(div);

    // Subscribe to the stream
    var subscribeProps = {height:240, width:320};
    session.subscribe(streams[i], div.id);
  }
}
