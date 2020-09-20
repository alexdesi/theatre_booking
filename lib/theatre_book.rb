# frozen_string_literal: true

require_relative './row'

class TheatreBook
  ROWS_NUMBER = 100

  def initialize
    @seats = Array.new(ROWS_NUMBER) { Row.new }
  end

  def book(request_id: 0, row1:, col1:, row2:, col2:)
    result = {}

    # Check if the seat positions are valid
    seat_position_error = validate_seat_position(request_id, row1, col1, row2, col2)
    if seat_position_error
      result[:errors] = seat_position_error
      return result
    end

    row = seats[row1]

    # Check if the seat is already booked
    unless row.free_seats?(col1, col2)
      result[:errors] = "Request error (id:#{request_id}): seat(s) already booked."
      return result
    end

    new_row = row.clone

    new_row.book_sequence_of_seats(col1, col2)

    # Check if the the booking would leave single gaps
    if new_row.single_gaps_count.zero?
      seats[row1] = new_row
    else
      result[:errors] = "Request error (id:#{request_id}): single gap present on row #{row1}"
    end

    result
  end

  private

  def validate_seat_position(request_id, row1, col1, row2, col2)
    unless row_is_valid?(row1) && row_is_valid?(row2) && Row.valid_seat_numbers?(col1, col2)
      "Request error (id:#{request_id}): the seat position is not valid."
    end
  end

  def max_row
    ROWS_NUMBER - 1
  end

  def row_is_valid?(row_number)
    (0..max_row).include?(row_number)
  end

  attr_accessor :seats
end
