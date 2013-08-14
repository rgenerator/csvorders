require 'csv'

module Feed
  def self.get(file)
    CSV.open(file, :headers => :first_row, :return_headers => true)
  end
end


