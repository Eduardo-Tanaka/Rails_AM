class Address < ActiveRecord::Base
  belongs_to :person

  validates :neighborhood, :city, :state, :complement, length: { maximum: 128 }
  validates :number, length: { maximum: 10 }
  validates :zipcode, length: { maximum: 9 }
end
