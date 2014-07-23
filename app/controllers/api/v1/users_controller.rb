module Api
  module V1
class UsersController < ApplicationController
  before_filter :fetch_user, :except => [:index, :create]

  def fetch_user
    @user = User.find_by_id(params[:id])
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
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save

        format.json { render json: @user, status: :created }
        format.xml { render xml: @user, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
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

