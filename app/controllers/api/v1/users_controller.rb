module Api
  module V1
    class UsersController < ApplicationController
      #uncomment these if required format is xml;
      # needed to get data from response body;
      # require 'nokogiri'
      # require 'open-uri'
      http_basic_authenticate_with :name => "exampleadmin@railstutorial.org",
                                   :password => "asdasd"
      before_filter :fetch_user, :except => [:index, :create]
      respond_to :json

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
        respond_with @user
      end

      def create
        respond_with User.create(user_params)

        #request body in json example
#        {"user" : {
#            "email" : "test@yopmail.com",
#            "name" : "arun",
#           "password" : "asdasdasd",
#           "password_confirmation"  : "asdasdasd"
#      }
#     }

        #data acquisition for xml format
        # doc = Nokogiri::XML.parse(request.body.read)
        # name = doc.xpath("//name/text()")
        # email = doc.xpath("//email/text()")
        # password = doc.xpath("//password/text()")
        # password_confirmation = doc.xpath("//password_confirmation/text()")

      end

      def edit

      end

      def update
        respond_with @user.update_attributes(user_params)
      end

      def destroy
        respond_with @user.destroy
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation) if params[:user]
      end

      def fetch_user
        @user = User.find_by_id(params[:id])
      end


    end
  end
end

