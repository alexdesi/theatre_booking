require_relative '../lib/theatre_book'

RSpec.describe TheatreBook do
  describe 'book a seat' do
    subject(:theatre_book) { described_class.new }

    context 'when seats are available' do
      it 'reserves the seats' do
        expect(theatre_book.book(row_number: 1, first_seat: 3, last_seat: 6)).to be true
      end
    end

    context 'when at least a seat is already booked' do
      it 'does NOT reserves the seat' do
        theatre_book.book(row_number: 1, first_seat: 3, last_seat: 6)

        expect(
          theatre_book.book(row_number: 1, first_seat: 6, last_seat: 7) # Seat 6 is alreay booked
        ).to be false
      end
    end

    context 'when 2 bookings are consecutive' do
      it 'does reserves the seat' do
        theatre_book.book(row_number: 1, first_seat: 3, last_seat: 6)

        expect(
          theatre_book.book(row_number: 1, first_seat: 7, last_seat: 8)
        ).to be true
      end
    end

    context 'when 2 bookings have a single gap' do
      it 'does now allow to book the seats' do
        theatre_book.book(row_number: 1, first_seat: 3, last_seat: 6)

        expect(
          theatre_book.book(row_number: 1, first_seat: 8, last_seat: 9)
        ).to be false
      end
    end

    context 'when the row OR seat number is invalid' do
      it 'raises an error' do
        theatre_book.book(row_number: 51, first_seat: 1, last_seat: 3)
      end
    end
  end
end
