class Admin::UsersController < ApplicationController

  before_filter :restrict_access
  before_filter :is_admin?

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def make_admin
    @user = User.find(params[:user_id])
    @user.admin = true
    @user.save
    redirect_to admin_users_path
  end

  # DONS notes
  # def show     
  #   @user = User.find(params[:id].to_i)
  # end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname} was created!"
    else
      render :new
    end
  end

  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to admin_users_path
  # end

  def destroy
    @user = User.find(params[:id])
    UserMailer.goodbye_email(@user).deliver if @user.destroy
    redirect_to admin_users_path, notice: "#{@user.firstname} deleted successfully."
    @user.destroy
  end

  protected

  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :email, :admin, :password, :password_confirmation
    )
  end

end