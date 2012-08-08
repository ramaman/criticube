# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Criticube::Application.initialize!

Rails::Initializer.run do |config|
  if Rails.env.production?  
    config.middleware.use Rack::WWW, :www => true  
  end     
end 