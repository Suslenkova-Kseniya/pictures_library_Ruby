class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  def show
  end
  def index
    if current_user.admin?
      @pictures = Picture.all
    else
      flash[:alert] = "Only admin can see all users"
      redirect_to current_user
    end
  end
  def new
    @picture = Picture.new
  end
  def edit
  end
  def create
    @picture = Picture.new(picture_params)
    @picture.users << current_user
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
    if !current_user.admin?
      @user = current_user
      @record = UserPicture.where(user_id: @user.id, picture_id: @picture.id).first
      # debugger(do: "info")
      @record.destroy
      redirect_to user_path
    else
      @picture.destroy
      redirect_to pictures_path
    end
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end
  def picture_params
    params.require(:picture).permit(:title, :description)
  end
end
