class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, only: [:update, :set_complete, :destroy, :following, :followers]

  def index
    @search_query = UserSearchService.new(params[:search])
    @users = @search_query.find_users.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    @user.confirmation = @user.sign_up_token
    if @user.save
      UserMailer.welcome_mail(@user).deliver
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
        flash[:success] = "Check email for confirmation link"
      end
    else
      render 'new'
    end

  end

  def set_complete
    if @user.can_activate?
      if @user.confirmation == params[:confirmation]
        @user.update_attribute(:state, true)
        # @user.activate!
        redirect_to signin_path
        flash[:success] = "Account confirmed"

      respond_to do |format|
        UserMailer.welcome_mail(@user).deliver
        sign_in @user
        format.html { redirect_to @user }
        flash[:success] = "Welcome to the Sample App!"
      end
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    followers_or_following(params[:id], params[:page])
  end

  def followers
    @title = "Followers"
    followers_or_following(params[:id], params[:page])
  end

  def notifications
   render 'notifications'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :notification)
  end

  # Before filters

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def find_user
    if params[:id]
      @user = User.find_by_id(params[:id])
      if @user.blank?
        redirect_to signin_url, notice: "Bad url."
      end
    end
  end
  
  def followers_or_following(user_id, page)
    @user = User.find(user_id)
    @users = @user.followed_users.paginate(page: page)
    render 'show_follow'
  end
end
