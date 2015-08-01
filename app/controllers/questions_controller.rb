class QuestionsController < ApplicationController

  before_action :find_question, only: [:edit, :update, :destroy]
  before_action :find_user
  before_action :find_donation, only: [:create, :edit, :update, :destroy]
  before_action :authenticate_user!

  def create
    @question = @donation.questions.create(question_params)
    @question.person = @person
    if @question.save
      redirect_to person_donation_path(@person, @donation), notice: "Question Created"
    else
      @categories = Category.all
      redirect_to :back
    end
  end

  def edit
    if current_user.id != @question.person.id
      redirect_to 'https://quem-me-quer.herokuapp.com/'
    else
       @question
    end
  end

  def update
    if @question.update(question_params)
      redirect_to person_donation_path(@person, @donation), notice: "Question Updated"
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to person_donation_path(@person, @donation), notice: "Question Deleted"
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question)
  end

  def find_donation
    @donation = Donation.find(params[:donation_id])
  end

  def find_user
    @person = Person.find(current_user.id) if current_user != nil
  end
end
