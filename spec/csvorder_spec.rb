require_relative '../lib/csvorders'
include Csvorders
require 'fakefs/spec_helpers'
require "fakefs/safe"
require 'OrderData'
require 'StubFilesystem'
require 'Feed'


describe Validator do
  extend FakeFS::SpecHelpers
  validator = Validator.new

  context "when a clean file is received" do
    order_filename = "orders.csv"
    order_file_opts = {:filename => order_filename, :header => :valid, :product_count => 1, :bad_lines => 0, :good_lines => 1, :projects => ["Project1"]}

    it "validates a set of valid headers" do
      StubFS.create_order_file(order_file_opts)
      rows = Feed.get(order_filename)
      headers = rows.shift
      validator.set_counts({:column_count=>headers.count, :product_count=>1})
      validator.validate_header(headers).should == true
    end

    it "validates a row of valid data" do
      StubFS.create_order_file(order_file_opts)
      rows = Feed.get(order_filename)
      headers = rows.shift
      validator.validate(rows.first).should == true
    end

    it "has no validation errors" do
      StubFS.create_order_file(order_file_opts)
      rows = Feed.get(order_filename)
      headers = rows.shift
      validator.validation_errors.should be_empty
    end
  end

  context "when a dirty file is received" do
    order_filename = "orders.csv"
    order_file_opts = {:filename => order_filename, :product_count => 1, :bad_lines => 2, :good_lines => 0, :projects => ["Project1"]}

    context "with bad data" do
      it "contains validation error objects" do
        StubFS.create_order_file(order_file_opts)
        rows = Feed.get(order_filename)
        headers = rows.shift
        validator.set_counts({:column_count=>headers.count, :product_count=>1})

        validator.validate(rows.first)
        validator.validation_errors.should_not be_empty
      end
    end

    context "with bad addresses" do
      it "recognizes invalid headers" do
        StubFS.create_order_file(order_file_opts.merge({:header=>:invalid}))
        rows = Feed.get(order_filename)
        headers = rows.shift
        validator.set_counts({:column_count=>headers.count, :product_count=>1})

        validator.validate_header(headers).should == false
      end

      it "recognizes invalid data rows" do
        StubFS.create_order_file(order_file_opts)
        rows = Feed.get(order_filename)
        headers = rows.shift
        validator.set_counts({:column_count=>headers.count, :product_count=>1})

        validator.validate(rows.first).should == false
      end

      it "contains validation error objects" do
        StubFS.create_order_file(order_file_opts)
        rows = Feed.get(order_filename)
        headers = rows.shift
        validator.set_counts({:column_count=>headers.count, :product_count=>1})

        validator.validate(rows.first)
        validator.validation_errors.should_not be_empty
      end
    end
  end
end
