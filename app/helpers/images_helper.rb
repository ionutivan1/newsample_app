module ImagesHelper

  def gravatar_for(user)
    profile_pic = Image.profile_picture(user)
    if File.file?(profile_pic.image.path)
      image_tag(profile_pic.image.url(:thumb), alt: user.name, class: "gravatar")
    else
      image_tag("default.jpg",size:"50x50", alt: profile_pic.image.path, class: "gravatar")
    end
  end

end