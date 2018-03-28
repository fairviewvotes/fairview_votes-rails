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
      flash[:danger] = 'Email not found.'
      redirect_to sessions_new_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
