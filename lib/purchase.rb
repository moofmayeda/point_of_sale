class Purchase < ActiveRecord::Base
  has_many :sales
  belongs_to :return
  has_many :items, :through => :sales
end
