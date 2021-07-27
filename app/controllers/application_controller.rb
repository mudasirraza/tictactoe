class ApplicationController < ActionController::Base

  private

  def current_user
    if session[:session_id].blank?
      session.delete 'init'
    end
    
    @current_user ||= session[:session_id]
  end

  def current_game
    @current_game ||= Game.find_by_token(session[:token])
    @current_game ||= Game.where(user: current_user).last
  end
end
