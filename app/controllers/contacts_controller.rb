class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :simulation]

  def new
    @contact = Contact.new
  end



  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to root_path, flash: {notice: 'Merci pour le message, on vous recontacte rapidement !'}
    else
      render :new, flash: {error: 'Il doit y avoir un soucis dans le formulaire !'}
    end
  end

  def simulation
    @contact = Contact.new(simulation_params)
    if @contact.save
      redirect_to root_path, flash: {notice: 'Merci pour le message, on vous recontacte rapidement !'}
    else
      render 'pages/home', flash: {error: 'Il doit y avoir un soucis dans le formulaire !'}
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :message, :captcha)
  end

  def simulation_params
    params.require(:simulation).permit(:name, :email, :phone, :message, :captcha)
  end
end
