class ContactMessage
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include ActiveModel::ForbiddenAttributesProtection

  include SimpleCaptcha::ModelHelpers
  apply_simple_captcha

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :content, type: String

  validates_presence_of :content

  validates_email_format_of :email, unless: 'email.blank?'

  validates_presence_of :content

  validate do
    if email.blank? && phone.blank?
      errors.add(:email, "Пожалуйста введите ваш е-мейл или телефон чтобы мы могли связаться с вами.")
    end
  end

  after_create do
    ContactMailer.new_message_email(self).deliver
  end

  rails_admin do
    navigation_label 'Настройки'

    list do
      field :c_at
      field :name
      field :content
      field :email
      field :phone
    end
  end
end
