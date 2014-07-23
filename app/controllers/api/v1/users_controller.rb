module Api
  module V1
class UsersController < ApplicationController

  http_basic_authenticate_with :name => "exampleadmin@railstutorial.org",
                               :password => "asdasd"
  skip_before_filter :authenticate_user!,  :except => [:index, :create]

  before_filter :fetch_user, :except => [:index, :create]

  def fetch_user
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
    respond_to do |format|
      format.json { render json: @users }
      format.xml { render xml: @users }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @user }
      format.xml { render xml: @user }
    end
  end

  def create
    @user = User.new(params[:user])
    # @user.name = "asdasd"
    # @user.email = "ionut.ivan1@gmail.com"
    # @user.password = "asdasd"
    # @user.password_confirmation = "asdasd"
    #
    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :created }
        format.xml  { render :xml => @user.to_xml, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.json { head :user_params, status: :ok }
        format.xml { head :user_params, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

      end
  end
end

