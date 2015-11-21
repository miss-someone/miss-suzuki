require 'rake'
require 'airbrake/rake_handler'
if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key = ENV['ERRBIT_API_KEY']
    config.host    = ENV['ERRBIT_API_HOST']
    config.port    = ENV['ERRBIT_API_PORT']
    config.development_environments = []
    config.secure = config.port == 443

    # report exceptions that happen inside a rake task
    config.rescue_rake_exceptions = true
  end
end
