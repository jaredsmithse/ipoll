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
    @question = Question.find(params[:id])
    unless @question
      redirect_to root_path, :notice => "Question does not exist, you should not see this."
    end
  end

  private

  def question_params
    params.require(:question).permit(:id, :room_id, :description, :order)
  end

end
