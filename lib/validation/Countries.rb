require 'iso_country_codes'

class Countries
  def self.check_country(row, errors, opts)
    data_index = { :billing => 11, :shipping => 21 }
    begin
      get_country row[data_index[opts[:type]]]
    rescue Exception => e
      errors << {status: false, message: "Country code for #{opts[:type]} is invalid"}
    end
    errors
  end

  def self.get_country(code)
    begin
      country = IsoCountryCodes.find(code).alpha2
    rescue Exception => e
      country = ""
    end
    country
  end

end
