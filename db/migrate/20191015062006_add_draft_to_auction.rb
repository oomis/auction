class AddDraftToAuction < ActiveRecord::Migration[6.0]
  def change
    add_column :auctions, :draft, :boolean, :default => true
    add_column :auctions, :published_at, :datetime
  end
end
