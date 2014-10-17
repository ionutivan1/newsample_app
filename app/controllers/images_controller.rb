class ImagesController < ApplicationController
  before_action :start_update, only: [:update]

  def index

  end

  def new
  end

  def create
    @profile_pic = Image.new(image_params)
    @profile_pic.save
  end

  def update
    @profile_pic = @image_update.updateImage
    render 'show'
  end

  def show
    @profile_pic = Image.find_by(type: "user_image", element_id: current_user.id)
  end

  def destroy

  end

  private

  def image_params
    params.require(:image).permit(:element, :element_id, :image)
  end

  def start_update
    @image_update = ImageService::ImageUpdateService.new(params)
  end
end