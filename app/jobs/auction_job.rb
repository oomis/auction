class AuctionJob < ApplicationJob
  queue_as :default

  def perform(auction)
    # Do something later
    auctions.each do |auction|
      if auction.published_at <=  Time.now.utc
        auction.update(draft: false)
      end
    end
  end
end
