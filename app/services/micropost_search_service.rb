class MicropostSearchService

  def initialize(search)
    @search = search
  end

  def find
    @results = Micropost.content(@search)
  end



end