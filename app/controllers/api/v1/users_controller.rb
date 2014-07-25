module Api
  module V1
class UsersController < ApplicationController
require 'nokogiri'
require 'open-uri'
  http_basic_authenticate_with :name => "exampleadmin@railstutorial.org",
                               :password => "asdasd"
  before_filter :fetch_user, :except => [:index, :create]
  respond_to :xml
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
    respond_with User.find(params[:id])
  end

  def create
    #ciobaneala
    doc = Nokogiri::XML.parse(request.body.read)
    name = doc.xpath("//name/text()")
    email = doc.xpath("//email/text()")
    password = doc.xpath("//password/text()")
    password_confirmation = doc.xpath("//password_confirmation/text()")

    @user = User.new
    @user.name = name.to_s
    @user.email = email.to_s
    @user.password = password.to_s
    @user.password_confirmation = password_confirmation.to_s
    render :xml => @user
    #respond_with?
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    respond_with User.update(params[:id], user_params)
  end

  def destroy
    respond_with User.destroy(params[:id])
    # respond_to do |format|
    #   if @user.destroy
    #     format.json { head :no_content, status: :ok }
    #     format.xml { head :no_content, status: :ok }
    #   else
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #     format.xml { render xml: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) if params[:user]
  end

      end
  end
end

