module ImageService
  class ImageUpdateService
    def initialize(params)
      @image_params = params[:user]
      @element = params[:user][:element]
      @element_id = params[:id]
    end

    def updateImage
      gettheimage = find_image
      update(gettheimage)
    end

    private
    def find_image
      Image.find_by(element: @element, element_id: @element_id)
    end

    def update(bla)
        bla.update_params(@image_params)
    end
  end
end