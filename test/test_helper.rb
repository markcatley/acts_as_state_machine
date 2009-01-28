$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_record'
require 'active_record/fixtures'
require "#{File.dirname(__FILE__)}/../init"
include ScottBarron::Acts::StateMachine

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(ENV['DB'] || 'sqlite3')

load(File.dirname(__FILE__) + "/schema.rb") if File.exist?(File.dirname(__FILE__) + "/schema.rb")

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures"
$:.unshift(Test::Unit::TestCase.fixture_path)

class Test::Unit::TestCase #:nodoc:
  fixtures :all
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end