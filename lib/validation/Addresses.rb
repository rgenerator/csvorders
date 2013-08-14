class Addresses
  def self.check_shipping_address(row, errors)
    country_in_alpha2 = Countries::get_country(row[21])
    name = min_max_check(row[15], 2, 35)  || errors << status(false, "Shipping name")
    phone = min_max_check(row[16], 5, 35) || errors << status(false, "Shipping phone")
    add1 = min_max_check(row[17], 2, 35)  || errors << status(false, "Shipping address 1")
    add2 = min_max_check(row[18], 0, 35)  || errors << status(false, "Shipping address 2")
    city = min_max_check(row[19], 2, 35)  || errors << status(false, "Shipping city")
    state = check_state(:state => row[22] ,:country => country_in_alpha2) || errors << status(false, "Shipping state")
    zip = check_zip(:zip => row[20], :country => country_in_alpha2) || errors << status(false, "Shipping zip")

    errors
  end

  def self.check_billing_address(row, errors)
    country_in_alpha2 = Countries::get_country(row[11])
    name  = min_max_check(row[6], 2, 35)  || errors << status(false, "Billing name")
    email = check_email_address(row[7])   || errors << status(false, "Billing email")
    add1  = min_max_check(row[8], 2, 35)  || errors << status(false, "Billing address 1")
    add2  = min_max_check(row[9], 0, 35)  || errors << status(false, "Billing address 2")
    city  = min_max_check(row[10], 2, 35) || errors << status(false, "Billing city")
    phone = min_max_check(row[12], 5, 35) || errors << status(false, "Billing phone")
    state = check_state(:state => row[13], :country => country_in_alpha2) || errors << status(false, "Billing state")
    zip   = check_zip(:zip => row[14], :country => country_in_alpha2) || errors << status(false, "Billing zip")

    errors
  end

  private

  def self.status(type, message="")
    {status: type, message: message}
  end

  def self.check_email_address(email_address)
    status(true) if email_address.length > 1 && email_address.match(/\w\@\w/)
  end

  def self.check_zip(opts)
    c = opts[:country].downcase
    return status(true) if ["ae", "cl", "co", "do", "eg", "hk", "ie", "mo", "ve"].include?(c)
    return status(true) if c != 'us' && ! c.empty?
    check_us_zip(opts[:zip])
  end

  def self.check_us_zip(zip)
    zip = zip.gsub(/\D/, "")
    return status(true) if zip.length == 5
    return status(true) if zip.length == 9
    false
  end

  def self.check_state(opts)
    status(true) if min_max_check(opts[:state], 2, get_state_abbreviation_limit(opts[:country].downcase))
  end

  def self.get_state_abbreviation_limit(country)
    {:us => 2, :ca => 2}[country.to_sym] || 35
  end

  def self.min_max_check(str, min, max)
    str = "" if str.nil?
    status(true) if str.length >= min && str.length <= max
  end

end
