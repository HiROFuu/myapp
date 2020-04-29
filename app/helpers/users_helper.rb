module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  # 下記、実装したい
  # def icon_url(user, options = { size: 80 })
  #   if user.email.present?
  #     gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  #     size = options[:size]
  #     return "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  #   else
  #     return user.image_url
  #   end
  # end
  
end
