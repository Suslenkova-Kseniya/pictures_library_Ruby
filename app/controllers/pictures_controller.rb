class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  def show
  end
  def index
    @pictures = Picture.all
  end
  def new
    @picture = Picture.new
  end
  def edit
  end
  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to @picture
      flash[:notice] = "Picture was created successfully."
    else
      render 'new'
    end
  end

  def update
    if @picture.update(picture_params)
      flash[:notice] = "Picture was updated successfully."
      redirect_to @picture
    else
      render 'edit'
    end
  end
  def destroy
    @picture.destroy
    redirect_to pictures_path
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end
  def picture_params
    params.require(:picture).permit(:title, :description)
  end
end
