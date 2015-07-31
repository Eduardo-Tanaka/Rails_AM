class HomesController < ApplicationController
  def index
    @donations = Donation.includes(:photos).all.order("created_at DESC").where(status: 1).limit(8)
  end
  def search
    @donations = Donation.includes(:photos).where(status: 1).where("title like ? or description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
  end
end
