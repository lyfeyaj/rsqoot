RSqoot.configure do |config|
  # config.public_api_key        = 'YOUR PUBLIC API KEY'
  # config.private_api_key       = 'YOUR PRIVATE API KEY'
  # config.base_api_url          = 'https://api.sqoot.com'
  # config.authentication_method = :header
  # config.read_timeout          = 60.seconds
  # config.expired_in            = 1.hour
end

SqootClient ||= RSqoot::Client.new