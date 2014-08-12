class SetDefaultForSales < ActiveRecord::Migration
  def change
    change_column :sales, :quantity, :integer, :default => 1
  end
end
