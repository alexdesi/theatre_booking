# frozen_string_literal: true

require './lib/booking_requests_loader'

puts 'Processing bookings ...'

booking_loader = BookingRequestsLoader.new('data/booking_requests')
result = booking_loader.process
errors = booking_loader.errors

puts errors
puts '- - - '
puts "There were: #{errors.count} incorrect booking requests."
