class Auction < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :bids, dependent: :destroy
end
