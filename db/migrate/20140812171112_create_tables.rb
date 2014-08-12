class CreateTables < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.timestamps
    end

    create_table :purchases do |t|
      t.date :date
      t.belongs_to :cashier
      t.timestamps
    end

    create_table :cashiers do |t|
      t.string :name
      t.timestamps
    end

    create_table :returns do |t|
      t.belongs_to :purchase
      t.belongs_to :item
      t.integer :quantity
      t.timestamps
    end

    create_table :sales do |t|
      t.belongs_to :purchase
      t.belongs_to :item
      t.integer :quantity
      t.timestamps
    end
  end
end
