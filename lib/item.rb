class Item < ActiveRecord::Base
  belongs_to :sale
  belongs_to :return
end
