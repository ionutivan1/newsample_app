module ImagesHelper

  def gravatar_for(user)
    profile_pic = Image.profile_picture(user)

    if profile_pic.image.url(:original, false)
      gravatar_url = profile_pic.image.url(:original, false)
    else
      gravatar_url = profile_pic.image.url(:default_url, false)
    end

    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

end