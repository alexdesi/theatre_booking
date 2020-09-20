# frozen_string_literal: true

require_relative '../lib/booking_requests_loader'

RSpec.describe BookingRequestsLoader do
  describe 'load the booking requests' do
    subject(:loader) { described_class.new('data/sample_booking_requests') }

    it 'loads the booking requests' do
      results = loader.process

      errors = results.select { |r| r[:errors] }

      # TODO: investigate: 11 errors instead of 10
      # Note: the specification states that the provided bookings sample
      #       contains 10 errors, but this returns 11 errors.
      # puts errors # to show the errors
      expect(errors.count).to eq(10)
    end
  end
end
