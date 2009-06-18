RAILS_ROOT = File.join(File.dirname(__FILE__), '..')
require 'rubygems'
require 'active_record'
require 'action_controller'
require 'test_help'

require File.join(File.dirname(__FILE__), *%w(.. init))
include ScottBarron::Acts::StateMachine

ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__), 'debug.log'))
ActiveRecord::Base.configurations = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'database.yml')))
ActiveRecord::Base.establish_connection(ENV['DB'] || 'sqlite3')

load(File.join(File.dirname(__FILE__), 'schema.rb')) if File.exist?(File.join(File.dirname(__FILE__), 'schema.rb'))

ActiveSupport::TestCase.fixture_path = File.join(File.dirname(__FILE__), 'fixtures')
Dir[File.join(ActiveSupport::TestCase.fixture_path, '*.rb')].each { |file| require file }

class ActiveSupport::TestCase #:nodoc:
  fixtures :all
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end