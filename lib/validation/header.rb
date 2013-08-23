class Header
  def self.is_valid_header?(product_count, columns, row)
    headers = get_headers_as_array(row)
    valid_required = check_required_headers(product_count, columns, headers, :required)
    valid_product = check_product_headers(product_count, columns, headers, :product)
    p valid_required unless valid_required.empty?
    valid_required.empty? && valid_product
  end

  def self.check_product_headers(product_count, columns, headers, type)
    (1..product_count).each do |p|
      columns[type].each do |column|
        return false unless headers.include?("#{column}#{p}")
      end
    end
    true
  end

  def self.get_headers_as_array(row)
    row.collect{|f| f.first.downcase}
  end

  def self.check_required_headers(product_count, columns, headers, type)
    missing_headers = []
    columns[type].each do |column|
      missing_headers << column unless headers.include?(column)
    end
    missing_headers
  end
end
