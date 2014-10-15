# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'pusher'
# Initialize the Rails application.
Rails.application.initialize!
Pusher.app_id = '92765'
Pusher.key = '47997315232bbd9f561f'
Pusher.secret = 'ed8bb2ed4a3611d50dc9'