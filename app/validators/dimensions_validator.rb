class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.send("#{attribute}?".to_sym)
      file = value.queued_for_write[:original]
      return unless file
      dimensions = Paperclip::Geometry.from_file(file.path)
      width = options[:width]
      height = options[:height]
      locale_prefix = 'activerecord.errors.models.user.attributes.avatar.dimensions'
      record.errors[attribute] << I18n.t("#{locale_prefix}.width",
                                         width: width) unless dimensions.width >= width
      record.errors[attribute] << I18n.t("#{locale_prefix}.height",
                                         height: height) unless dimensions.height >= height
    end
  end
end
