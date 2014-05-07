class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private

  def current_user
    if session[:user_type] == 0
      @current_user ||= User.find_by_sql("SELECT * FROM users WHERE user_id = #{session[:user_id]};")[0] if session[:user_id]
    else
      @current_user ||= User.find_by_sql("SELECT * FROM employees WHERE user_id = #{session[:user_id]};")[0] if session[:user_id]
    end
  end


  def has_to_authenticate
  end
end
