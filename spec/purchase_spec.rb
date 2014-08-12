require 'spec_helper'

describe 'Purchase' do
  describe '#total' do
    it 'initiailize with a purchase_id, item_id, and quantity' do
      new_product = Item.create({name: 'slinky', price: 1})
      another_product = Item.create({name: 'deluxe megazord slinky', price: 2})
      other_product = Item.create({name: 'ruffio candy slinky', price: 6})
      new_cashier = Cashier.create({name: 'Wønka'})
      new_purchase = Purchase.create({date: '2014-08-02', cashier_id: new_cashier.id })
      new_sale = Sale.create({purchase_id: new_purchase.id, item_id: other_product.id, quantity: 10})
      another_sale = Sale.create({purchase_id: new_purchase.id, item_id: new_product.id, quantity: 1})
      other_sale = Sale.create({purchase_id: new_purchase.id, item_id: another_product.id, quantity: 2})
      expect(new_purchase.total).to eq 65
    end
  end

  describe '.report_by_date' do
    it 'adds up the total sales amount for a given date range' do
      product1 = Item.create({name: 'slinky', price: 1})
      product2 = Item.create({name: 'deluxe megazord slinky', price: 2})
      product3 = Item.create({name: 'ruffio candy slinky', price: 6})
      new_cashier = Cashier.create({name: 'Wønka'})
      purchase1 = Purchase.create({date: '2014-08-01', cashier_id: new_cashier.id })
      purchase2 = Purchase.create({date: '2014-08-02', cashier_id: new_cashier.id })
      purchase3 = Purchase.create({date: '2014-09-01', cashier_id: new_cashier.id })
      sale1 = Sale.create({purchase_id: purchase1.id, item_id: product1.id, quantity: 10})
      sale2 = Sale.create({purchase_id: purchase2.id, item_id: product2.id, quantity: 1})
      sale3 = Sale.create({purchase_id: purchase3.id, item_id: product3.id, quantity: 2})
      expect(Purchase.report_by_date("2014-08-01", "2014-08-15")).to eq 12
    end
  end
end
