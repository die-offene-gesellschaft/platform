class Content < ApplicationRecord
  def self.from_controller_action_or_key(args)
    contents = Content
               .where(controller_action_name: "#{args[:controller_name]}##{args[:action_name]}")
               .order(:order)
    contents = Content
               .where(controller_action_name: "#{args[:controller_name]}##{args[:content_key]}")
               .order(:order) unless contents.any?
    contents = Content
               .where(controller_action_name: "#{args[:content_key]}#show")
               .order(:order) unless contents.any?
    contents
  end
end
