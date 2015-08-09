class HomesController < ApplicationController

  before_action :find_user
  before_action :find_categories, only: [:search, :category]

  def index
    @donations1 = Donation.includes(:photos).all.order("created_at DESC").where(status: 1, category_id: 1).limit(8)
    @donations2 = Donation.includes(:photos).all.order("created_at DESC").where(status: 1, category_id: 2).limit(8)
    @donations3 = Donation.includes(:photos).all.order("created_at DESC").where(status: 1, category_id: 3).limit(8)

    @donations = Array.new
    @donations << @donations1
    @donations << @donations2
    @donations << @donations3

    respond_to do |format|
      format.html { @donations }
      format.json { render json: @donations }
    end
  end

  def search
    @donations = Donation.includes(:photos).where(status: 1).where("title like ? or description like ?", "%#{params[:search]}%", "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 3)
  end

  def category
    if params[:category] == nil
      @donations = Donation.includes(:photos).where(status: 1).where("title like ? or description like ?", "%#{params[:title]}%", "%#{params[:title]}%").paginate(:page => params[:page], :per_page => 3)
    else
      @donations = Donation.includes(:photos).where(status: 1).where("category_id = ?", "#{params[:category][:category_id]}").where("title like ? or description like ?", "%#{params[:title]}%", "%#{params[:title]}%").paginate(:page => params[:page], :per_page => 3)
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
