require 'set'

class Currencies
  ACCEPTED = Set.new %w(AUD CAD CHF DKK EUR GBP NOK SEK USD)

  def self.check_currency(row, errors)
    errors << {status: false, message: "Currency is not supported"} unless ACCEPTED.include?(row[3])
    errors
  end
end
