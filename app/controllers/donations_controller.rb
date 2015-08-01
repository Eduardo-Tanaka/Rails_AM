class DonationsController < ApplicationController

  before_action :find_user
  before_action :find_categories, only: [:new, :edit, :delete_image]
  before_action :find_donation, only: [:show, :edit, :update, :destroy, :delete_image]
  before_action :authenticate_user!, except: [:show]

  def index
    @donations = @person.donations.includes(:photos).all
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.person_id = @person.id
    @donation.category_id = params[:donation][:category_id]
    if @donation.status == '1' && params[:images] == nil
      @categories = Category.all
      flash[:alert] = 'Para publicar uma doação é necessário anexar pelo menos 1 foto'
      return render 'new'
    end
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
    if current_user.id != @donation.person.id
      redirect_to 'https://quem-me-quer.herokuapp.com/'
    else
      @categories = Category.all
      @donation
    end
  end

  def update
    @donation.attributes = donation_params
    if params[:images] == nil
      if @donation.status == '1' && (@donation.photos.count == 0)
        @categories = Category.all
        flash[:alert] = 'Para publicar uma doação é necessário anexar pelo menos 1 foto'
        return render 'edit'
      else
        if @donation.save
          return redirect_to person_donation_path(@person, @donation), notice: "Donation updated"
        else
          @categories = Category.all
          return render 'edit'
        end
      end
    else
      if @donation.update(donation_params)
        if params[:images]
          params[:images].each { |image| @donation.photos.create(image: image) }
        end
        return redirect_to person_donation_path(@person, @donation), notice: "Donation updated"
      else
        @categories = Category.all
        return render 'edit'
      end
    end

  end

  def destroy
    @donation.destroy
    redirect_to person_donations_path, notice: "Donation deleted"
  end

  def delete_image
    if @donation.photos.count == 1 && @donation.status == '1'
      flash[:alert] = "Não pode deletar todas as fotos se a doação estiver publicada"
      return render 'edit'
    end
    photo = Photo.find(params[:format])
    flash[:notice] = "Image deleted"
    photo.destroy
    render 'edit'
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
