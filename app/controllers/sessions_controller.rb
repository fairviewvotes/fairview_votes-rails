class SessionsController < ApplicationController
  def new
  end

  def create
    user_info = request.env['omniauth.auth']
    puts "NAME: #{user_info['info']['email']}"

    redirect_to users_path
  end
end
