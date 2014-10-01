class ImagesController < ApplicationController

  before_action :start_update, only: [:update]

  def index

  end

  def new
  end

  def create
    @image = Image.new(image_params)
    @image.save
  end

  def update
    @a = @image_update.updateImage
    render 'show'
  end

  def show

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