class UserSearchService

  def initialize(search)
    @search = search
  end

  def find
    @users = User.all.where("name like ?", "%#{@search}%")
    return @users
  end

  def set_direction(users)

  end
end