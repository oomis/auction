class BidsController < ApplicationController
  before_action :set_auction
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @bid = @auction.bids.new(bid_params)
    @bid.user = current_user
    if @bid.amount >= @auction.starting_price
      @bid.save
    else
        flash[:notice] = 'You need to bid higher than the starting price.'
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def bid_params
    params.require(:bid).permit(:amount, :auction_id)
  end
  def set_auction
    @auction = Auction.find(params[:auction_id])
  end
end
