require 'spec_helper'

describe 'Cashier' do
  describe '#report_by_cashier' do
    it 'return the number of customers served by a given cashier for a given date range' do
      cashier1 = Cashier.create({name: 'Wønka'})
      cashier2 = Cashier.create({name: 'Skip'})
      purchase1 = Purchase.create({date: '2014-08-01', cashier_id: cashier1.id })
      purchase2 = Purchase.create({date: '2014-08-02', cashier_id: cashier2.id })
      purchase3 = Purchase.create({date: '2014-09-01', cashier_id: cashier1.id })
      expect(cashier1.report_by_cashier("2014-08-01", "2014-09-15")).to eq 2
    end
  end
end
