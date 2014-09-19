class UserSearchService

  def initialize(search)
    @search = search
  end

  def find_users
    get_users
  end


    private

    def get_users
    @users = User.all.where("name like ?", "%#{@search}%")
    return @users
  end

 end