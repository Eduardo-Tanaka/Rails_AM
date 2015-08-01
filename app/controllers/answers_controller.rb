class AnswersController < ApplicationController

  before_action :find_answer, only: [:edit, :update, :destroy]
  before_action :find_user
  before_action :find_question, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!

  def new
    if current_user.id != @question.donation.person.id
      redirect_to 'https://quem-me-quer.herokuapp.com/'
    else
      @answer = Answer.new
    end
  end

  def create
    @answer = Answer.create(answer_params)
    @answer.question = @question
    if @answer.save
      redirect_to person_donation_path(@person, @question.donation)
    else
      render 'new'
    end
  end

  def edit
    if current_user.id != @question.donation.person.id
      redirect_to 'https://quem-me-quer.herokuapp.com/'
    else
      @answer
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to person_donation_path(@person, @answer.question.donation), notice: "Answer Updated"
    else
      render 'edit'
    end
  end

  def destroy
    @answer.destroy
    redirect_to person_donation_path(@person, @answer.question.donation), notice: "Question Deleted"
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:answer)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_user
    @person = Person.find(current_user.id) if current_user != nil
  end
end
