class UsersController < ApplicationController

  def new
    @user = User.new
  end
  def index
    if current_user.admin?
      @users = User.all
    else
      flash[:alert] = "Only admin can see all users"
      redirect_to current_user
    end
  end

  def show
    @user = User.find(params[:id])
    if !(current_user.admin? || @user == current_user)
      flash[:alert] = "Only admin can see other users"
      redirect_to current_user
    end
  end

  def edit
    @user = User.find(params[:id])
    if !(current_user.admin? || @user == current_user)
      flash[:alert] = "Only admin can edit other users"
      redirect_to current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if pic_params.count <= 3
      if @user.update(pic_params)
        flash[:notice] = "Picture collection was updated successfully."
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash[:alert] = "You can choose only 3 pictures"
      redirect_to 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "#{@user.username} was successfully sign up"
      redirect_to users_path
    else
      render "new"
    end
  end

  private
  def pic_params
    params.require(:user).permit(picture_ids: [])
  end

  def user_params
    params.require(:user).permit(:username, :email)

  end
end
