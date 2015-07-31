class PersonsController < ApplicationController

  before_action :find_user
  before_action :authenticate_user!, except: [:show]

  def index

  end

  def show

  end

  def edit

  end

  def update
    if @person.update(person_params)

      redirect_to @person, notice: "Person updated"
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def person_params
    params.require(:person).permit(:status, :user_name, :ranking, :name, :cpf, :rg, :birth_date, :company_name, :trading_name, :cnpj,
      address_attributes: [:id, :zipcode, :address, :number, :complement, :neighborhood, :city, :state],
      phones_attributes: [:id, :phone])
  end

  def find_user
    @person = Person.find(current_user.id) if current_user != nil
  end
end
