class ContactMailer < ActionMailer::Base
  def new_message_email(message)
    @message = message

    #if message.attachment?
    #  attachments[message.attachment.identifier] = File.read(message.attachment.current_path)
    #end
    binding.pry
    mail(
        from: Settings.default_email_from(default: 'noreply@rscx.ru'),
        to: Settings.form_email(default: 'glebtv@ya.ru'),
        subject: "[#{Settings.email_topic(default: 'с сайта')}] #{message.name} #{message.email}"
    )
  end
end
