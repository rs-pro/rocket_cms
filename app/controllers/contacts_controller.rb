class ContactsController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(message_params)
    if RocketCMS.configuration.contacts_captcha
      meth = :save_with_captcha
    else
      meth = :save
    end

    if @contact_message.send(meth)
      redirect_to :contacts_sent
    else
      flash.now[:alert] = @contact_message.errors.full_messages.join("\n")
      render action: "new"
    end
  end

  def sent
  end

  private
  def message_params
    params.require(:contact_message).permit(RocketCMS.configuration.contacts_fields.keys + [:name, :email, :phone, :content, :captcha, :captcha_key])
  end
end
