require 'row'

class TheatreBook
  ROWS_NUMBER = 100

  def initialize
    @seats = Array.new(ROWS_NUMBER) { Row.new }
  end

  def book(row_number:, first_seat:, last_seat:)
    raise('The seat is not valid.') unless row_is_valid?(row_number)

    row = seats[row_number]

    unless row.seats_are_valid?(first_seat, last_seat)
      (0..Row::COLS_NUMBER).include?(first_seat) &&
           (0..Row::COLS_NUMBER).include?(last_seat)
      raise('The seat is not valid.')
    end

    row = seats[row_number]

    return false unless row.free_seats?(first_seat, last_seat)

    new_row = row.clone
    new_row.book_sequence_of_seats(first_seat, last_seat)

    if new_row.single_gaps_count.zero?
      seats[row_number] = new_row
      true
    else
      false
    end
  end

  private

  def max_row
    ROWS_NUMBER - 1
  end

  def row_is_valid?(row_number)
    (0..max_row).include?(row_number)
  end

  attr_accessor :seats
end
