json.extract! auction, :id, :title, :desc, :starting_price, :end_date, :user_id, :image, :created_at, :updated_at
json.url auction_url(auction, format: :json)
