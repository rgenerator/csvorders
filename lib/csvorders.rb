require "csvorders/version"
require 'validation/header'
require 'validationerrors'
require 'validation/addresses'
require 'validation/countries'
require 'validation/languages'
require 'validation/currencies'
require 'validation/products'
require 'validation/structure'

module Csvorders
  class Validator
    attr_accessor :column_count, :product_count, :product_indexes, :validation_errors, :debug
    attr_reader :columns

    def initialize
      @product_count = 0
      @column_count = 0
      @product_indexes = [nil, 23, 28, 33]
      @columns = { :required     => ['project_id', 'partner_order_id', 'language', 'currency', 'order_date', 'shipping_tax', 'full_name', 'email', 'billing_address_1', 'billing_city', 'billing_country', 'billing_phone', 'billing_state', 'billing_zip', 'shipping_full_name', 'shipping_phone', 'shipping_address_1', 'shipping_city', 'shipping_zip', 'shipping_country', 'shipping_state'],
                   :not_required => ['billing_address_2', 'shipping_address_2'],
                   :product      => ['product_id', 'price_per', 'quantity', 'shipping_per', 'tax_per']}
      @validation_errors = []
      @debug = false
    end

    def set_counts(opts)
      self.column_count = opts[:column_count]
      self.product_count = opts[:product_count]
    end

    def validate_header(row)
      Header.is_valid_header?(product_count, columns, row) ? true : false
    end

    def validate(row)
      p row if debug
      status = is_valid?(row)
      return true if status == true
      record_error(status, row)
      false
    end

    private

    def is_valid?(row)
      errors = []
      errors = Structure.check_column_count(column_count, row, errors)
      errors = Products.check_products(self, row, errors)
      errors = Languages.check_language(row, errors)
      errors = Countries.check_country(row, errors, :type => :billing)
      errors = Countries.check_country(row, errors,  :type => :shipping)
      errors = Currencies.check_currency(row, errors)
      errors = Addresses.check_billing_address(row, errors)
      errors = Addresses.check_shipping_address(row, errors)
      errors.empty? ? true : errors
    end

    def record_error(messages, row)
      validation_errors << ValidationErrors.new({:line_number => $.,
                                                 :line_contents => row,
                                                 :errors => messages})
    end

 end
end
