require 'spec_helper'

describe 'Item' do
  it 'initiailize with a price and product name' do
    new_product = Item.create({name: 'slinky', price: 1})
    expect(new_product).to be_an_instance_of Item
  end
end
