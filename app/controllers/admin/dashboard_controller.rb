class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @rooms = Room.all
    @bookings = Booking.includes(:user, :room).order(created_at: :desc).limit(10)
  end
end
