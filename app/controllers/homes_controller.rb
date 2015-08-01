class HomesController < ApplicationController

  before_action :find_user
  before_action :find_categories, only: [:search, :category]

  def index
    @donations = Donation.includes(:photos).all.order("created_at DESC").where(status: 1).limit(8)
  end

  def search
    @donations = Donation.includes(:photos).where(status: 1).where("title like ? or description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
  end

  def category
    if params[:category] == nil
      @donations = Donation.includes(:photos).where(status: 1).where("title like ? or description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @donations = Donation.includes(:photos).where(status: 1).where("category_id = ?", "#{params[:category][:category_id]}").where("title like ?", "%#{params[:title]}%")
    end
    render 'search'
  end

  private

  def find_user
    @person = Person.find(current_user.id) if current_user != nil
  end

  def find_categories
    @categories = Category.all
  end
end