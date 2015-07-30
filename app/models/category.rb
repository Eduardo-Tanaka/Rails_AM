class Category < ActiveRecord::Base
  has_many :donations
end
