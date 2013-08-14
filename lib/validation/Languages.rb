require 'iso-639'

class Languages
  def self.check_language(row, errors)
    errors << {status: false, message: "Language not found"} unless ISO_639.find_by_code(row[2])
    errors
  end
end
