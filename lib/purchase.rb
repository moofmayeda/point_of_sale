class Purchase < ActiveRecord::Base
  belongs_to :sale
  belongs_to :return
  has_many :items, :through => :sales
end
