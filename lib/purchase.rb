class Purchase < ActiveRecord::Base
  has_many :sales
  has_many :returns
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

  def return item_id, quantity
    target_sale = self.sales.where(item_id: item_id).first
    self.returns.create(purchase_id: self.id, item_id: item_id, quantity: quantity)
    if (target_sale.quantity - quantity) == 0
      target_sale.destroy
    else
      target_sale.update(quantity: target_sale.quantity - quantity)
    end
  end
end
