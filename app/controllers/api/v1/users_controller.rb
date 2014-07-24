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
    name_with_tags = doc.xpath("//name").to_s
    name =name_with_tags.match ("(?<=\<name\>).*?(?=\<\/name\>)")
    email_with_tags = doc.xpath("//email").to_s
    email =email_with_tags.match ("(?<=\<email\>).*?(?=\<\/email\>)")
    password_with_tags = doc.xpath("//password").to_s
    password =password_with_tags.match ("(?<=\<password\>).*?(?=\<\/password\>)")
    password_confirmation_with_tags = doc.xpath("//password_confirmation").to_s
    password_confirmation =password_confirmation_with_tags.match ("(?<=\<password_confirmation\>).*?(?=\<\/password_confirmation\>)")

    @user = User.new
    @user.name = name
    @user.email = email
    @user.password = password
    @user.password_confirmation = password_confirmation
    @user.save

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

