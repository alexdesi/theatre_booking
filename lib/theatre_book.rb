class TheatreBook
  ROWS_NUMBER = 100
  COLS_NUMBER = 50

  def initialize
    @seats = Array.new(ROWS_NUMBER) { Array.new(COLS_NUMBER, false) }
  end

  def book(row_number:, first_seat:, last_seat:)
    unless (0..max_row).include?(row_number) &&
           (0..max_col).include?(first_seat) &&
           (0..max_col).include?(last_seat)
      raise('The seat is not valid.')
    end

    if free_seats?(row_number, first_seat, last_seat) && single_gaps_count(row_number, first_seat, last_seat).zero?
      (first_seat..last_seat).each do |col|
        seats[row_number][col] = true
      end

      true
    else
      false
    end
  end

  private

  def free_seats?(row_number, first_seat, last_seat)
    seats_to_book = (first_seat..last_seat).map { |col| @seats[row_number][col] }

    seats_to_book.none?
  end

  def single_gaps_count(row_number, first_seat, last_seat)
    row_seats = @seats[row_number].clone

    (first_seat..last_seat).each do |col|
      row_seats[col] = true
    end

    gaps = 0
    i = 1

    # Exclude the first and last seats
    while i <= max_col - 1
      current_seat = row_seats[i]
      previous_seat = row_seats[i - 1]
      next_seat = row_seats[i + 1]

      gaps += 1 if previous_seat && !current_seat && next_seat

      i += 1
    end

    gaps
  end

  def max_row
    ROWS_NUMBER - 1
  end

  def max_col
    COLS_NUMBER - 1
  end

  attr_accessor :seats
end
