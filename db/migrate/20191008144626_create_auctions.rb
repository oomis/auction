class CreateAuctions < ActiveRecord::Migration[6.0]
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :desc
      t.float :starting_price
      t.datetime :end_date
      t.references :user, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
