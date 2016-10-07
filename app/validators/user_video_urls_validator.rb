class UserVideoUrlsValidator < ActiveModel::Validator
  def initialize(_model)
  end

  def self.validate_video_url(record)
    video_url = record.video_url
    return true unless video_url
    return true if video_url.strip.empty?
    return true if video_url =~ %r{
        https:\/\/(
        www.youtube.com\/watch\?v=[a-zA-Z0-9\-_]+|
        youtu.be\/[a-zA-Z0-9\-_]+|
        vimeo.com\/[0-9]+
        )
      }x
    record.errors[:video_url] << I18n.t('users.errors.video-url')
  end
end
