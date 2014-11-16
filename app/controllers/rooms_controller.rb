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
    if current_user.pollee?
      if @room && @room.current_question
        question = @room.current_question
        redirect_to "/questions/#{question.id}", question: question
      else
        redirect_to root_path, notice: "Questions are not open."
      end
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path, :notice => "Room deleted."
  end

  private

  def room_params
    params.require(:room).permit(:name,:id,:url)
  end

end
