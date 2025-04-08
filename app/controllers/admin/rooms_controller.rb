# app/controllers/admin/rooms_controller.rb
class Admin::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_room, only: [ :edit, :update, :destroy ]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to admin_rooms_path, notice: "Room created successfully"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @room.update(room_params)
      redirect_to admin_rooms_path, notice: "Room updated"
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to admin_rooms_path, notice: "Room deleted"
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :capacity, :price_per_hour, :active)
  end
end

