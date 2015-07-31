class HomesController < ApplicationController

  before_action :find_user

  def index
    @donations = Donation.includes(:photos).all.order("created_at DESC").where(status: 1).limit(8)
  end
  def search
    @donations = Donation.includes(:photos).where(status: 1).where("title like ? or description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
  end

  private

  def find_user
    @person = Person.find(current_user.id) if current_user != nil
  end
end
