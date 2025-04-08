# app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.includes(:room)
  end

  def new
    @rooms = Room.where(active: true)
  end

  def create
    room_ids = params[:room_ids]&.take(3) || []
    start_time = Time.parse(params[:start_time])
    end_time = Time.parse(params[:end_time])

    Booking.transaction do
      room_ids.each do |room_id|
        Booking.create!(
          user: current_user,
          room_id: room_id,
          start_time: start_time,
          end_time: end_time
        )
      end
    end

    redirect_to bookings_path, notice: "Booking created successfully"
  rescue => e
    redirect_to new_booking_path, alert: "Booking failed: Time Slot not avaliable"
  end

  def cancel
    @booking = Booking.find(params[:id])
    @booking.cancel
    redirect_to bookings_path, notice: "Booking canceled successfully"
  end
end
