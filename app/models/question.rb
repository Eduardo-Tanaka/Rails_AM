class Question < ActiveRecord::Base

  belongs_to :person
  belongs_to :donation
  has_one :answer, dependent: :destroy

  validates :question, presence: true
end
