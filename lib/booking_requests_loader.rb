# frozen_string_literal: true

require_relative './theatre_book'

class BookingRequestsLoader
  REQUEST_REGEXP = /\((?<index>\d+),(?<row1>\d+):(?<col1>\d+),(?<row2>\d+):(?<col2>\d+)\)/.freeze

  def initialize(filename)
    @theatre_book = TheatreBook.new
    @filename = filename
    @results = []
  end

  def process
    File.foreach(filename) do |line|
      request = line.match(REQUEST_REGEXP)

      results << theatre_book.book(
        request_id: request[:index], row1: request[:row1].to_i, col1: request[:col1].to_i,
        row2: request[:row2].to_i, col2: request[:col2].to_i
      )
    end

    results
  end

  def errors
    results.filter_map { |e| e[:errors] unless e[:errors].nil? }
  end

  private

  attr_reader :theatre_book, :filename, :results
end
