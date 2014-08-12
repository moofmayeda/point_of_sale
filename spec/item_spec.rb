require 'spec_helper'

describe 'Item' do
  it 'initiailize with a price and product name' do
    new_product = Item.create({name: 'slinky', price: 1})
    expect(new_product).to be_an_instance_of Item
  end

  describe '#report_by_sales' do
    it 'return the number of sales associated with a product' do
      product1 = Item.create({name: 'slinky', price: 1})
      product2 = Item.create({name: 'deluxe megazord slinky', price: 2})
      product3 = Item.create({name: 'ruffio candy slinky', price: 6})
      new_cashier = Cashier.create({name: 'Wønka'})
      purchase1 = Purchase.create({date: '2014-08-01', cashier_id: new_cashier.id })
      purchase2 = Purchase.create({date: '2014-08-02', cashier_id: new_cashier.id })
      purchase3 = Purchase.create({date: '2014-09-01', cashier_id: new_cashier.id })
      sale1 = Sale.create({purchase_id: purchase1.id, item_id: product1.id, quantity: 10})
      sale2 = Sale.create({purchase_id: purchase2.id, item_id: product2.id, quantity: 1})
      sale3 = Sale.create({purchase_id: purchase3.id, item_id: product1.id, quantity: 2})
      expect(product1.report_by_sales).to eq 12
    end
  end

  describe '#report_by_returns' do
    it 'return the number of returns associated with a product' do
      product1 = Item.create({name: 'slinky', price: 1})
      product2 = Item.create({name: 'deluxe megazord slinky', price: 2})
      product3 = Item.create({name: 'ruffio candy slinky', price: 6})
      new_cashier = Cashier.create({name: 'Wønka'})
      purchase1 = Purchase.create({date: '2014-08-01', cashier_id: new_cashier.id })
      purchase2 = Purchase.create({date: '2014-08-02', cashier_id: new_cashier.id })
      purchase3 = Purchase.create({date: '2014-09-01', cashier_id: new_cashier.id })
      return1 = Return.create({purchase_id: purchase1.id, item_id: product1.id, quantity: 10})
      return2 = Return.create({purchase_id: purchase2.id, item_id: product2.id, quantity: 1})
      return3 = Return.create({purchase_id: purchase3.id, item_id: product1.id, quantity: 2})
      expect(product1.report_by_returns).to eq 12
    end
  end

  describe '.top_seller' do
    it 'return the best selling product' do
      product1 = Item.create({name: 'slinky', price: 1})
      product2 = Item.create({name: 'deluxe megazord slinky', price: 2})
      product3 = Item.create({name: 'ruffio candy slinky', price: 6})
      new_cashier = Cashier.create({name: 'Wønka'})
      purchase1 = Purchase.create({date: '2014-08-01', cashier_id: new_cashier.id })
      purchase2 = Purchase.create({date: '2014-08-02', cashier_id: new_cashier.id })
      purchase3 = Purchase.create({date: '2014-09-01', cashier_id: new_cashier.id })
      sale1 = Sale.create({purchase_id: purchase1.id, item_id: product2.id, quantity: 10})
      sale2 = Sale.create({purchase_id: purchase2.id, item_id: product3.id, quantity: 1})
      sale3 = Sale.create({purchase_id: purchase3.id, item_id: product1.id, quantity: 2})
      expect(Item.top_seller).to eq product2
    end
  end

  describe '.sort_by_sales' do
    it 'sorts all items from most to least sold' do
      product1 = Item.create({name: 'slinky', price: 1})
      product2 = Item.create({name: 'deluxe megazord slinky', price: 2})
      product3 = Item.create({name: 'ruffio candy slinky', price: 6})
      new_cashier = Cashier.create({name: 'Wønka'})
      purchase1 = Purchase.create({date: '2014-08-01', cashier_id: new_cashier.id })
      purchase2 = Purchase.create({date: '2014-08-02', cashier_id: new_cashier.id })
      purchase3 = Purchase.create({date: '2014-09-01', cashier_id: new_cashier.id })
      sale1 = Sale.create({purchase_id: purchase1.id, item_id: product2.id, quantity: 10})
      sale2 = Sale.create({purchase_id: purchase2.id, item_id: product3.id, quantity: 1})
      sale3 = Sale.create({purchase_id: purchase3.id, item_id: product1.id, quantity: 2})
      expect(Item.sort_by_sales).to eq [product2, product1, product3]
    end
  end
end
