class Item < ActiveRecord::Base
  has_many :sales
  has_many :returns

  def self.top_seller
    self.all.max_by{|item| item.report_by_sales}
  end

  def self.top_returner
    self.all.max_by{|item| item.report_by_returns}
  end

  def self.sort_by_sales
    self.all.sort_by{|item| item.report_by_sales}.reverse
  end

  def self.sort_by_returns
    self.all.sort_by{|item| item.report_by_returns}.reverse
  end

  def report_by_sales
    # self.sales.map{|sale| sale.quantity}.reduce(:+)
    self.sales.sum('quantity')
  end

  def report_by_returns
    # self.returns.map{|a_return| a_return.quantity}.reduce(:+)
    self.returns.sum('quantity')
  end

end
