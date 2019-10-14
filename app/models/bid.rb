class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction
  validates :amount, presence: true, allow_blank: false
end
