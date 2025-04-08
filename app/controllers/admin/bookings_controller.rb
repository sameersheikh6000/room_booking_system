class Admin::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @bookings = Booking.includes(:user, :room).order(created_at: :desc)
  end

  def approve
    @booking = Booking.find(params[:id])
    @booking.update(status: 1, approved: true)
    redirect_to admin_bookings_path, notice: "Booking approved successfully"
  end
end
