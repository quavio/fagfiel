RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend DeviseMacros, :type => :controller
  config.use_transactional_fixtures = false
  config.before(:suite) do
    ActiveRecord::Base.connection.execute "SET client_min_messages TO warning;"
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end
