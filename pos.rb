require 'active_record'
require './lib/cashier'
require './lib/item'
require './lib/purchase'
require './lib/return'
require './lib/sale'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "SLINKY STORE POINT OF SALE PROGRAM"
  puts "1) Cashiers login"
  puts "2) Managers menu"
  puts "3) Exit"
  case gets.chomp.to_i
  when 1
    cashier_login
    cashiers_menu
  when 2
    managers_menu
  when 3
    exit
  else
    puts "Enter a valid option"
  end
  welcome
end

def managers_menu
  puts "1) Add item to inventory"
  puts "2) Add new cashier"
  puts "3) Total sales by date-range"
  puts "4) Sales by Cashier"
  puts "5) Top selling item"
  puts "6) Most returned item"
  puts "7) View inventory"
  puts "8) Exit to main menu"


  case gets.chomp.to_i
  when 1
    add_item
  when 2
    add_cashier
  when 3
    total_sales
  when 4
    sales_by_cashier
  when 5
    sales_by_item
  when 6
    returns_by_item
  when 7
    view_items
  when 8
    welcome
  else
    puts "Enter a valid option"
  end
  managers_menu
end

def add_cashier
  puts "Enter the cashier's name:"
  Cashier.create({name: gets.chomp})
end

def view_cashiers
  Cashier.all.each do |cashier|
    puts cashier.id.to_s + ") " + cashier.name
  end
end

def total_sales
  puts "Enter a start date:"
  start_date = gets.chomp.to_s
  puts "Enter an end date:"
  end_date = gets.chomp.to_s
  sales = Purchase.report_by_date(start_date, end_date)
  puts "Total sales for #{start_date}-#{end_date} is $#{sales}"
end

def sales_by_cashier
  view_cashiers
  puts "Enter a cashier's id"
  cashier = gets.chomp.to_i
  puts "Enter a start date:"
  start_date = gets.chomp.to_s
  puts "Enter an end date:"
  end_date = gets.chomp.to_s
  num_sales = Cashier.find(cashier).report_by_cashier(start_date, end_date)
  puts "#{Cashier.find(cashier).name} helped #{num_sales} customers from #{start_date}-#{end_date}"
end

def sales_by_item
  best = Item.top_seller
  puts "#{best.name} is the best selling product! We have sold #{best.report_by_sales} #{best.name}s"
end

def returns_by_item
  worst = Item.top_returner
  puts "#{worst.name} is the most returned product! Customers have returned #{worst.report_by_returns} #{worst.name}s"
end

def add_item
  puts "Enter product description:"
  name = gets.chomp.to_s
  puts "Enter retail price of #{name}:"
  price = gets.chomp.to_s
  Item.create({price: price, name: name})
end

def return_item
  view_items
  puts "Enter an item id to return:"
  item = gets.chomp.to_i
  puts "Enter quantity to return:"
  quantity = gets.chomp.to_i
  puts "Enter the purchase id"
  Purchase.find(gets.chomp.to_i).return(item, quantity)
  puts "Successfully returned"
end

def view_items
  Item.all.each do |item|
    puts "#{item.id}) #{item.name}--$#{item.price}--#{item.report_by_sales} sold"
  end
end

def show_receipt purchase_id
  system 'clear'
  current_purchase = Purchase.find(purchase_id)
  puts "Purchase ##{current_purchase.id}\n"
  current_purchase.sales.each do |sale|
    current_item = Item.find(sale.item_id)
    puts "#{current_item.name}--$#{current_item.price}--#{sale.quantity}"
    end
  puts "total: $#{current_purchase.total}"
end

def sale(purchase_id)
  view_items
  puts "Enter item number"
  item_id = gets.chomp.to_i
  puts "Quantity, if more than one"
  quantity = gets.chomp.to_i
  quantity = 1 if quantity == 0
  Sale.create({:purchase_id => purchase_id, :item_id => item_id, :quantity => quantity})
  puts "Add item? y/n"
  case gets.chomp
  when 'y'
    sale(purchase_id)
  when 'n'
    show_receipt(purchase_id)
    cashiers_menu
  end
end

def new_purchase
  new_purchase = Purchase.create({:date => Time.new.strftime("%Y-%m-%d"), :cashier_id => @cashier.id})
  sale(new_purchase.id)
end

def cashier_login
  view_cashiers
  puts "Enter cashier id"
  @cashier = Cashier.find(gets.chomp.to_i)
end

def cashiers_menu
  puts "1) New purchase"
  puts "2) Return item"
  puts "3) Main Menu"
  case gets.chomp.to_i
  when 1
    new_purchase
  when 2
    return_item
  when 3
    welcome
  else
    puts "Enter a valid option"
  end
  cashiers_menu
end

welcome
