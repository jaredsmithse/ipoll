class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def create
    room = Room.new(room_params)
    room.user = current_user
    room.user.role = :owner
    room.save
    redirect_to root_path, :notice => "Room created."
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path, :notice => "Room deleted."
  end

  private

  def room_params
    params.require(:room).permit(:name,:url)
  end

end
