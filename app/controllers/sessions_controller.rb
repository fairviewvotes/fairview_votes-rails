class SessionsController < ApplicationController
  def new
  end

  def create
    user_info = request.env['omniauth.auth']
    email = user_info['info']['email']

    user = User.find_by_email email

    if user.present? # successful log in
      puts "LOGGED IN"
      flash[:danger] = 'Logged in!'
      log_in user
      redirect_to user
    else
      puts "EMAIL NOT RECOGNIZED"
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
