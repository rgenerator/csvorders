require 'OrderData'

class StubFS
  def self.create_order_file(opts)
    FileUtils.mkdir_p("/tmp/rejected")
    FileUtils.mkdir_p("/tmp/accepted")

    File.open(opts[:filename], "w") do |f|
      f.puts OrderData.get_headers(opts).join(",")
      opts[:projects].each do | project_name |
        opts[:good_lines].times{ f.puts OrderData::good_lines(:count => opts[:product_count], :project => project_name) }
        opts[:bad_lines].times{ f.puts OrderData::bad_lines(:count => opts[:product_count], :project => project_name) }
      end
    end
  end
end


