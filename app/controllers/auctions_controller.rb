class AuctionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auction, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # auctionJob.perform_later auctions
  # auctionjob.perform_async(1, 2, 3)

  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.all.order('created_at DESC')
    # @auctions = Auction.not_published
    # @auctions = Auction.published
    # @auctions = Auction.published
    respond_to do |format|
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename='Auctions.xlsx'"
      }
      format.html { render :index }
      # format.html
      format.csv { send_data @auctions.to_csv }
    end
  end


  # GET /auctions/1
  # GET /auctions/1.json
  def show
    @bid = Bid.new
    @bids = @auction.bids.order('amount DESC')
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user

    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
        format.json { render :show, status: :created, location: @auction }
      else
        format.html { render :new }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auctions/1
  # PATCH/PUT /auctions/1.json
  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to auctions_url, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:title, :desc, :starting_price, :end_date, :user_id, :image, :published_at)
    end
end
