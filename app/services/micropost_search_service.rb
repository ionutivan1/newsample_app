class MicropostSearchService

  def initialize(search)
    @search = search
  end

  def find
    get_microposts
  end

  private
  def get_microposts
    @microposts = Micropost.all.where("content like ?", "%#{@search}%")
    return @microposts
  end

end