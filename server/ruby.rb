# First, make sure you have the gem installed
#   For Sinatra, gem install 'opentok' and then require 'opentok' in your ruby file
#   For Rails, put gem 'opentok' in your gemfile and bundle installed

# Initialize an OpenTok Object
API_KEY = ''                # Replace with your API Key
API_SECRET = ''            # Replace with your API Secret
OTSDK = OpenTok::OpenTokSDK.new API_KEY, API_SECRET

# Creating Session object with p2p enabled
sessionProperties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "enabled"}    # or disabled
sessionId = OTSDK.createSession( @location, sessionProperties )

# Generating a token
token = OTSDK.generateToken :session_id => session, :role => OpenTok::RoleConstants::PUBLISHER, :connection_data => "username=Bob,level=4"
