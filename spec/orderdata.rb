class OrderData
  def self.get_headers(opts)
    headers = %w(project_id partner_order_id language currency order_date shipping_tax full_name
    email billing_address_1 billing_address_2 billing_city billing_country
    billing_phone billing_state billing_zip shipping_full_name shipping_phone
    shipping_address_1 shipping_address_2 shipping_city shipping_zip shipping_country
    shipping_state product_Id1 price_per1 quantity1 shipping_per1 tax_per1)

    self.bad_header(headers) if opts[:header] == :invalid
    headers
  end

  def self.bad_header(headers)
    r = rand(headers.count)
    headers[r] = "badheader"
    headers
  end

  def self.good_lines(opts)
    lines = ""
    opts[:count].times do
      lines << "\"#{opts[:project]}\"," << self.good_elements.join(",") << "\n"
    end
   lines
  end

  def self.bad_lines(opts)
    lines = ""
    opts[:count].times do
      lines << "\"#{opts[:project]}\"," << self.bad_elements.join(",") << "\n"
    end
    lines
  end

  def self.bad_elements
      %w(
      ""
      "xx"
      "GBX"
      "May 3,2013 00:00:00"
      "Tax"
      "JOE SMITH JOE SMITH JOE SMITH JOE SMITH JOE SMITH"
      "joeexampleaddress"
      "555 Main Street 555 Main Street 555 Main Street"
      "Apartment 5 Apartment 5 Apartment 5 Apartment 5"
      "Anywhereville Anywhereville Anywhereville Anywhereville"
      "XX"
      "4156"
      "Great Britain"
      ""
      "JOE SMITH JOE SMITH JOE SMITH JOE SMITH JOE SMITH"
      "7803"
      "555 Main Street 555 Main Street 555 Main Street"
      "Apartment 5 Apartment 5 Apartment 5 Apartment 5"
      "Anywhereville Anywhereville Anywhereville Anywhereville"
      ""
      "XX"
      "Great Britain"
      "00886979894228"
      "$50"
      -1
      "shipping cost"
      "tax cost")
  end

  def self.good_elements
      %w(
      "45-49705"
      "en"
      "GBP"
      "2013-03-15 00:00:00"
      0
      "JOE SMITH"
      "joe@example.com"
      "555 Main Street"
      "Apartment 5"
      "Anywhereville"
      "GB"
      "1234156"
      "Great Britain"
      "DN159QN"
      "JOE SMITH"
      "1724307803"
      "555 Main Street"
      "Apartment 5"
      "Anywhereville"
      "DN159QN"
      "GB"
      "Great Britain"
      "886979894228"
      50
      1
      0
      0)
  end
end


