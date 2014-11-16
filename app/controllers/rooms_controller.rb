class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def create
    room = Room.new(room_params)
    room.user_id = current_user.id
    room.user.role = :owner
    room.save
    redirect_to "/rooms/#{room.url}", :notice => "Room created."
  end

  def show
    @room = Room.find_by_url(params[:id])
    @questions = @room.questions.sort_by(&:order)
    unless @room
      redirect_to root_path, :notice => "Room does not exist, please create one."
    end
    if @room.presenting?
      if @room.current_question.nil?
        if current_user.owner?
          @questions.first.set_current!
        else
          redirect_to root_path, notice: "Room is not ready"
        end
      end
      question = @room.current_question
      redirect_to "/questions/#{question.id}"
    end
    if @room.current_question.nil? && current_user.pollee?
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path, :notice => "Room deleted."
  end

  def activate
    room = Room.find(params[:id])
    room.activate!
    redirect_to room_path, id: room.url
  end

  private

  def room_params
    params.require(:room).permit(:name,:id,:url)
  end

end
