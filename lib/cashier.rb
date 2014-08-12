class Cashier < ActiveRecord::Base
  belongs_to :purchase

  def report_by_cashier(start_date, end_date)
    Purchase.where("date BETWEEN ? AND ? AND #{self.id} = cashier_id", start_date, end_date).count
  end
end
