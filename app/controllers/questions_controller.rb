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
    @question = Question.find(params[:question_id])
    @room = @question.room
    if current_user.pollee?
      unless @question == @room.current_question
        redirect_to "/rooms/#{@room.url}"
      end
      @answered = current_user.answered?(@room.current_question)
    end
  end

  def start
    @question = Question.find(params[:id])
    @question.update_attribute(:accepting, true)
    render nothing: true
  end

  def stop
    @question = Question.find(params[:id])
    @question.update_attribute(:accepting, false)
    render nothing: true
  end


  private

  def question_params
    params.require(:question).permit(:id, :room_id, :description, :order)
  end

end
