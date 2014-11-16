class AnswersController < ApplicationController

  def index
    @answer = Answer.all
  end

  def create
    answer = Answer.new(question_params)
    answer.save
  end

  def show
    @answer = Answer.find(params[:id])
    unless @answer
      redirect_to root_path, :notice => "Answer does not exist, you should not see this."
    end
  end

  private

  def room_params
    params.require(:answer).permit(:id,:question_id,:description,:option_num)
  end

end
