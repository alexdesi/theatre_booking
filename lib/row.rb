class Row
  COLS_NUMBER = 50

  def initialize
    @row = Array.new(COLS_NUMBER, false)
  end

  def book_sequence_of_seats(first_seat, last_seat)
    (first_seat..last_seat).each do |col|
      book_seat(col)
    end
  end

  def book_seat(col)
    @row[col] = true
  end

  def free_seats?(first_seat, last_seat)
    seats_to_book = (first_seat..last_seat).map { |col| @row[col] }

    seats_to_book.none?
  end

  def single_gaps_count
    gaps = 0
    i = 1
    while i <= max_col - 1 # Exclude the first and last seats
      current_seat = @row[i]
      previous_seat = @row[i - 1]
      next_seat = @row[i + 1]

      gaps += 1 if previous_seat && !current_seat && next_seat

      i += 1
    end

    gaps
  end

  def seats_are_valid?(first_seat, last_seat)
    (0..COLS_NUMBER).include?(first_seat) && 
    (0..Row::COLS_NUMBER).include?(last_seat)
  end

  private

  def max_col
    COLS_NUMBER - 1
  end
end
