require 'active_record'
require 'cashier'
require 'item'
require 'purchase'
require 'return'
require 'sale'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.before(:each) do
    Item.all.each { |item| item.destroy }
  end
end
