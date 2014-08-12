class Purchase < ActiveRecord::Base
  has_many :sales
  belongs_to :return
  has_many :items, :through => :sales

  def total
    amount = 0
    self.sales.each do |sale|
      amount += sale.quantity * Item.find(sale.item_id).price
    end
    amount
  end

  def self.report_by_date start_date, end_date
    amount = 0
    self.where("date BETWEEN ? AND ?", start_date, end_date).each do |purchase|
      amount += purchase.total
    end
    amount
  end
end
