class ContactMessage
  include RocketCMS::Models::ContactMessage
  RocketCMS.apply_patches self
  rails_admin &RocketCMS.contact_message_config
end

