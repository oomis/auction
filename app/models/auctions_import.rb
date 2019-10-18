class AuctionsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".Csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_auctions
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      auction = Auction.find_by_id(row["id"]) || Auction.new
      auction_id.attributes = row.to_hash
      auction
    end
  end

  def imported_auctions
    @imported_auctions ||= load_imported_auctions
  end

  def save
    if imported_auctions.map(&:valid?).all?
      imported_auctions.each(&:save!)
      true
    else
      imported_auctions.each_with_index do |auction, index|
        auction.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 6}: #{msg}"
        end
      end
      false
    end
  end

end
