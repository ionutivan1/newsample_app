class UserSearchService

  def initialize

  end

  def find(search)
    @users = User.all.where("name like ?", "%#{search}%")
    return @users
  end

  def set_direction(users)

  end
end