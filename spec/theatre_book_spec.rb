# frozen_string_literal: true

require_relative '../lib/theatre_book'

RSpec.describe TheatreBook do
  describe 'book a seat' do
    subject(:theatre_book) { described_class.new }

    context 'when seats are available' do
      it 'reserves the seats' do
        result = theatre_book.book(row1: 1, col1: 3, row2: 1, col2: 6)
        expect(result[:errors]).to be_nil
      end
    end

    context 'when at least a seat is already booked' do
      it 'does NOT reserves the seat' do
        theatre_book.book(row1: 1, col1: 3, row2: 1, col2: 6)

        result = theatre_book.book(row1: 1, col1: 6, row2: 1, col2: 7)

        expect(
          result[:errors]
        ).to eq 'Request error (id:0): seat(s) already booked.'
      end
    end

    context 'when 2 bookings are consecutive' do
      it 'does reserves the seat' do
        theatre_book.book(row1: 1, col1: 3, row2: 1, col2: 6)

        result = theatre_book.book(row1: 1, col1: 7, row2: 1, col2: 8)

        expect(result[:errors]).to be_nil
      end
    end

    context 'when 2 bookings have a single gap' do
      it 'does now allow to book the seats' do
        theatre_book.book(row1: 1, col1: 3, row2: 1, col2: 6)

        result = theatre_book.book(row1: 1, col1: 8, row2: 1, col2: 9)

        expect(result[:errors]).to eq 'Request error (id:0): single gap present on row 1'
      end
    end

    context 'when the row OR seat number is invalid' do
      it 'raises an error' do
        result = theatre_book.book(row1: 100, col1: 0, row2: 1, col2: 1)

        expect(result[:errors]).to eq 'Request error (id:0): the seat position is not valid.'
      end
    end
  end
end
