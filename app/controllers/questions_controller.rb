class QuestionsController < ApplicationController

  def index
    @question = Question.all
  end

  def create
    @question = Question.new(question_params)
    @question.save
    render layout: false
  end

  def show
    @room = Room.find_by_url(params[:room])
    @question = @room.questions.find(params[:question])
    unless @question
      redirect_to root_path, :notice => "Question does not exist, you should not see this."
    end
    if current_user.pollee?
      unless @question == @room.current_question
        redirect_to "/rooms/#{@room.url}"
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:id, :room_id, :description, :order)
  end

end
