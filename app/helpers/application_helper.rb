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

  # this method smells of :reek:ControlParameter
  # this method smells of :reek:TooManyStatements
  # rubocop:disable Metrics/CyclomaticComplexity
  def network_share_link(network, resource = '')
    base_uri = 'https://twitter.com/home?status=' if network == :twitter
    base_uri = 'https://www.facebook.com/sharer.php?u=' if network == :facebook
    resource_uri = request.original_url if resource == ''
    resource_uri = event_url(resource) if resource.is_a? Event
    resource_uri = user_url(resource) if resource.is_a? User
    resource_uri = blogpost_url(resource) if resource.is_a? Blogpost
    "#{base_uri}#{URI.escape(resource_uri)}"
  end

  def twitter_share_link(resource = '')
    network_share_link(:twitter, resource)
  end

  def facebook_share_link(resource = '')
    network_share_link(:facebook, resource)
  end

  def member_signed_in?
    user_signed_in? && current_user.terms_of_use
  end
end
