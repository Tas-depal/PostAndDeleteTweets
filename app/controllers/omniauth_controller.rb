# frozen_string_literal: true

# Api module
  # Omniauth controller
class OmniauthController < ApplicationController

  # .................Twitter Omniauth.................
  def twitter
    @user = find_user
    @user = create_user unless @user.present?
  end

  private

  def find_user
    @user = User.find_by(uid: request.env['omniauth.auth']['uid'],
                 provider: request.env['omniauth.auth']['provider'])
    if @user.present?
      session[:user_id] = @user.id 
      redirect_to home_path
    else
      return
    end
  end

  def create_user
    user_params = {
      uid: request.env['omniauth.auth']['uid'],
      provider: request.env['omniauth.auth']['provider'],
      name: request.env['omniauth.auth']['info']['name'],
      email: request.env['omniauth.auth']['info']['email'],
      password_digest: SecureRandom.hex(10),
      access_token: request.env['omniauth.auth']['credentials']['token'],
      access_token_secret: request.env['omniauth.auth']['credentials']['secret'],
      api_key: request.env['omniauth.auth']['extra']['access_token'].consumer.key,
      api_key_secret: request.env['omniauth.auth']['extra']['access_token'].consumer.secret
    }
    @user = User.create(user_params)
    token = jwt_encode(user_id: user.id)
    session[:user_id] = @user.id
    redirect_to home_path
  end
end
