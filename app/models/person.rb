class Person < ActiveRecord::Base
  belongs_to :user
  has_one :address
  has_many :donations
  has_many :phones

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phones

  validates :rg, length: { maximum: 15 }
  validates :name, length: { maximum: 100 }
  validates :company_name, :trading_name, length: { maximum: 128 }

  has_many :questions
end
