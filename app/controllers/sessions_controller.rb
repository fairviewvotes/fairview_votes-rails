class SessionsController < ApplicationController
  def new
  end

  def create
    user_info = request.env['omniauth.auth']
    email = user_info['info']['email']

    user = User.find_by_email email

    if user.present? # successful log in
      flash[:danger] = 'Logged in!'
      log_in user

      user.update_registered_status

      if user.registered_to_vote?
        redirect_to registration_good_path
      else
        redirect_to registration_new_path
      end
    else

      flash[:danger] = 'Email not found.'
      redirect_to sessions_new_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
