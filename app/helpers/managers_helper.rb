module ManagersHelper
  def gravatar_for(manager, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(manager.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: manager.name, class: "gravatar")
  end
end
