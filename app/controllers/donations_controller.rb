class DonationsController < ApplicationController

  before_action :find_user
  before_action :find_categories, only: [:new, :edit, :delete_image]
  before_action :find_donation, only: [:show, :edit, :update, :destroy, :delete_image]
  before_action :authenticate_user!, except: [:show]

  def index
    @donations = @person.donations.all
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.person_id = @person.id
    @donation.category_id = params[:donation][:category_id]
    if params[:images]
      params[:images].each { |image| @donation.photos.new(image: image) }
    end
    if @donation.save
      redirect_to person_donation_path(@person, @donation), notice: "Donation created"
    else
      @categories = Category.all
      render 'new'
    end
  end

  def show

  end

  def edit

  end

  def update
    if @donation.update(donation_params)
      if params[:images]
        params[:images].each { |image| @donation.photos.create(image: image) }
      end
      redirect_to person_donation_path(@person, @donation), notice: "Donation updated"
    else
      render 'edit'
    end
  end

  def destroy
    @donation.destroy
    redirect_to person_donations_path, notice: "Donation deleted"
  end

  def delete_image
    photo = Photo.find(params[:format])
    photo.destroy
    render 'edit', notice: "Image deleted"
  end

  private

  def donation_params
    params.require(:donation).permit(:category_id, :title, :description, :status, :situation, :images, :question)
  end

  def find_donation
    @donation = Donation.find(params[:id])
  end

  def find_categories
    @categories = Category.all
  end

  def find_user
    @person = Person.find(current_user.id) if current_user != nil
  end

end
