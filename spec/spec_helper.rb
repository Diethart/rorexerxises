module Sorcery
  module TestHelpers
    module Rails
      def login_user_post(email, password)
        page.driver.post(sessions_path, { user: { email: email, password: password }})
      end
    end
  end
end
RSpec.configure do |config|
  config.include Sorcery::TestHelpers::Rails

  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
