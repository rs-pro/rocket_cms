class ContactsController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(message_params)

    if @contact_message.save_with_captcha
      redirect_to :contacts_sent
    else
      if @contact_message.errors.any?
        flash.now[:alert] = @contact_message.errors.full_messages.join("\n")
      end
      render action: "new"
    end
  end

  def sent
  end

  private
  def message_params
    params.require(:contact_message).permit(:name, :email, :phone, :content, :captcha, :captcha_key)
  end
end
