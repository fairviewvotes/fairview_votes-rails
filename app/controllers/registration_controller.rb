class RegistrationController < ApplicationController
  def new
  end

  def good
  end

  def check
    u = current_user
    u.update_registered_status

    if u.registered_to_vote?
      redirect_to registration_good_path
    else
      flash.now[:danger] = 'Something went wrong. Please try again later.'
      redirect_to sessions_new_path
    end
  end
end
