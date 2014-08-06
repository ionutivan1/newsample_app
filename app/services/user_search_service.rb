
class MicropostSearchService

  def initialize

  end

  def find(search)
    @results = Micropost.content(search)
  end



end