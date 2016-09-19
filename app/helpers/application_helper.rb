module ApplicationHelper
  def bootstrap_class_for(flash_type)
    return 'alert-info' if flash_type.eql?('notice')
    return 'alert-success' if flash_type.eql?('success')
    return 'alert-danger' if flash_type.eql?('error')
    return 'alert-danger' if flash_type.eql?('alert')
    flash_type.to_s
  end

  def icon_name_for(flash_type)
    return 'info-circle' if flash_type.eql?('notice')
    return 'check-circle' if flash_type.eql?('success')
    return 'exclamation-triangle' if flash_type.eql?('error')
    return 'exclamation' if flash_type.eql?('alert')
  end

  def twitter_share_link(resource)
    link = '#'
    if resource.is_a? Event
      link = "https://twitter.com/home?status=#{URI.escape(event_url(resource))}"
    elsif resource.is_a? User
      link = "https://twitter.com/home?status=#{URI.escape(user_url(resource))}"
    end
    link
  end

  def facebook_share_link(resource)
    link = '#'
    if resource.is_a? Event
      link = "https://www.facebook.com/sharer.php?u=#{URI.escape(event_url(resource))}"
    elsif resource.is_a? User
      link = "https://www.facebook.com/sharer.php?u=#{URI.escape(user_url(resource))}"
    end
    link
  end
end
