module ImageService
  class ImageUpdateService
    def initialize(params)
      @image_params = params[:user][:image]
      @element = params[:user][:element]
      @element_id = params[:id]
    end

    def updateImage
      get_the_image = find_image
      get_the_image.update_attributes(:image => @image_params)
      return get_the_image
    end

    private
    def find_image
      Image.find_by(element: @element, element_id: @element_id)
    end
  end
end