class TheatreBook
  ROW_MAX = 100
  SEAT_MAX = 50

  def initialize
    @seats = [1..ROW_MAX][1..SEAT_MAX]
  end

  def book(row_number, seat_number)
    raise('The seat is not valid.') unless (1..ROW_MAX).include?(row_number) && (1..SEAT_MAX).include?(seat_number)

    if seats[row_number, seat_number]
      raise('Seat already booked.')
    else
      seats[row_number, seat_number] = true
    end
  end

  private

  attr_accessor :seats
end
