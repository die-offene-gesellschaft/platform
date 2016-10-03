class UserFlagsValidator < ActiveModel::Validator

  def initialize(_model)
  end

  def self.validate_terms_of_use(record)
    unless record.terms_of_use
      unless record.newsletter
        error_message = I18n.t('users.errors.no-terms-of-use')
        record.errors[:terms_of_use] << error_message
      end
    end
  end
end
