require_relative '../lib/theatre_book'

RSpec.describe TheatreBook do
  describe 'book a seat' do
    subject(:theatre_book) { described_class.new }

    context 'when seat is available' do
      it 'reserves the seat' do
        expect(theatre_book.book(1, 3)).to be true
      end
    end

    context 'when seat is already booked' do
      it 'does NOT reserves the seat' do
        theatre_book.book(1, 3)

        expect { theatre_book.book(1, 3)}.to raise_error('Seat already booked.')
      end
    end

    context 'when the row OR seat number is invalid' do
      it 'raises an error' do
        theatre_book.book(51, 1)
      end
    end
  end
end
