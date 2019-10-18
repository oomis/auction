class Auction < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :bids, dependent: :destroy
  validates_presence_of :title

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |auction|
        csv << auction.attributes.values_at(*column_names)
      end
    end
  end


  # scope :draft, -> {
  #   where(:draft => true)
  # }

  # scope :draft, where(:draft => true)

  # scope :published, -> {
  #   where(:draft => false).where('published_at <= ?', Time.zone.now)
  # }

  scope :published, -> {
    where('published_at <= ? AND end_date >= ?', Time.zone.now, Time.zone.now)
  }
  #
  # scope :not_published, -> {
  #   where('published_at >= ?', Time.zone.now )
  # }

  # def not_published
  #   Auction.where('published_at <= ?', Time.zone.now)
  # end
  #
  # def time_remaining
  #   where('published_at <= ?', Time.zone.now )
  # end
  #
  # #
  # before_save :ensure_published_at, :unless => :draft?
  # protected
  # def ensure_published_at
  #   # Set it to current time if none has been specified.
  #   self.published_at ||= Time.zone.now
  # end
  #
  # def publish!
  #   self.draft = false
  #   self.save!
  # end

end
