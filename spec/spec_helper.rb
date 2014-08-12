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
    Sale.all.each { |sale| sale.destroy }
    Purchase.all.each { |purchase| purchase.destroy }
    Return.all.each { |a_return| a_return.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
  end
end
