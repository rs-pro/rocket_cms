class ContactMailer < ActionMailer::Base
  default from: "noreply@vashvkus.ru"

  def new_message_email(message)
    @message = message

    #if message.attachment?
    #  attachments[message.attachment.identifier] = File.read(message.attachment.current_path)
    #end

    mail(
        to: Settings.form_email(default: 'glebtv@ya.ru'),
        subject: "[ML форма] #{message.name} #{message.email}"
    )
  end
end
