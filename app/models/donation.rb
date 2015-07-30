class Donation < ActiveRecord::Base
  belongs_to :person
  has_many :photos, dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, :description, :situation, :category, :photos, presence: true
  validates :title, length: { maximum: 60 }

  has_many :questions, dependent: :destroy
end
