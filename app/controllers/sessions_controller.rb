class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def create
    user = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    user ||= set_canvas && User.create_with_auth(auth_hash)
    session[:user_id] = user.id
    # TODO @jeffersongirao shame on me, refatorar esssa coisa horrível e escrever testes 
    # redirect para url de retorno
    redirect_to Settings.facebook_app_url + session.delete(:return_to) and return if session[:return_to]
    redirect_to @canvas ? root_path(:canvas => true) : root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def set_canvas
    @canvas = true
  end
end
