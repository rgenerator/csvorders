class Products
  def self.check_products(v, row, errors)
    (product_count, columns, product_indexes) = v.product_count, v.columns, v.product_indexes
    valid_products = true
    (1..product_count).each do |product|
      (product_indexes[product]..product_indexes[product]+columns[:product].count-1).each do |product_column|
        errors << {status: false, message: "No product columns found"} if row[product_column].nil?
        errors << {status: false, message: "No product columns found"} if row[product_column].to_i < 0
      end
    end
    errors
  end
end

