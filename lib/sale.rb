class Sale < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :item
end
