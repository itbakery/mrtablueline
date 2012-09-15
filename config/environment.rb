# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mrtablueline::Application.initialize!
Stateflow.persistence = :mongoid
