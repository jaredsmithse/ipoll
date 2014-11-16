class AnswersController < ApplicationController

  def index
    @answer = Answer.all
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.save
    render 'answers/show', layout: false
  end

  def show
    @answer = Answer.find(params[:id])
    unless @answer
      redirect_to root_path, :notice => "Answer does not exist, you should not see this."
    end
  end

  def choose
    answer = Answer.find(params[:id])
    current_user.choose answer
    redirect_to "/questions/#{answer.question.id}"
  end

  private

  def answer_params
    params.require(:answer).permit(:id, :question_id, :description, :order)
  end

end
