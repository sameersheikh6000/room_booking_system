class Admin::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_booking, only: %i[approve destroy]

  def index
    @bookings = Booking.includes(:user, :room).order(created_at: :desc)
  end

  def approve
    @booking.update_columns(status: 1, approved: true)
    redirect_to admin_bookings_path, notice: "Booking approved successfully"
  end

  def destroy
    @booking.destroy
    redirect_to admin_bookings_path, notice: "Booking deleted"
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
