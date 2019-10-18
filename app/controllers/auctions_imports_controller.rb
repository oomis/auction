class AuctionsImportsController < ApplicationController
  def new
    @auctions_import = AuctionsImport.new
  end

  def create
    @auctions_import = AuctionsImport.new(params[:auctions_import])
    if @auctions_import.save
      redirect_to auctions_path
    else
      render :new
    end
  end
end
