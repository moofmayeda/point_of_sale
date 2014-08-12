require 'spec_helper'

describe 'Sale' do
  it 'initiailize with a purchase_id, item_id, and quantity' do
    new_product = Item.create({name: 'slinky', price: 1})
    another_product = Item.create({name: 'deluxe megazord slinky', price: 2})
    other_product = Item.create({name: 'ruffio candy slinky', price: 6})
    new_cashier = Cashier.create({name: 'Wønka'})
    new_purchase = Purchase.create({date: '2014-08-02', cashier_id: new_cashier.id })
    new_sale = Sale.create({purchase_id: new_purchase.id, item_id: other_product.id, quantity: 10})
    another_sale = Sale.create({purchase_id: new_purchase.id, item_id: new_product.id, quantity: 1})
    other_sale = Sale.create({purchase_id: new_purchase.id, item_id: another_product.id, quantity: 2})
    expect(new_purchase.sales).to eq [new_sale, another_sale, other_sale]
  end
  it "sets a default quantity of 1" do
    other_sale = Sale.create({purchase_id: 2, item_id: 4, quantity: 2})
    new_sale = Sale.create({purchase_id: 2, item_id: 3})
    expect(new_sale.quantity).to eq 1
    expect(other_sale.quantity).to eq 2
  end
end
