class Structure
  def self.check_column_count(column_count, row, errors)
    row.count == column_count ? true : errors << {status: false, message: "Wrong number of columns"}
    errors
  end
end
