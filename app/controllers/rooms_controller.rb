class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.where(active: true)
  end

  def show
    @room = Room.find(params[:id])
  end
end
