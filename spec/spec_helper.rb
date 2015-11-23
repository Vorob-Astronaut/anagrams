require './index.rb'
Dir[File.expand_path("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Services::AnagramHelper, anagram_helpers: true
end
