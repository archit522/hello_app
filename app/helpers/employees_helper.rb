module EmployeesHelper
  def gravatar_for(employee, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(employee.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: employee.name, class: "gravatar")
  end
end
