class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_sql("SELECT * FROM users WHERE mail = '#{params[:mail]}';")[0]
    employee= Employee.find_by_sql("SELECT * FROM employees WHERE mail = '#{params[:mail]}';")[0]

    if user.present? && user.authenticate(params[:password])
      session[:user_type] = 0
      session[:user_id] = user.user_id
      redirect_to incidents_url, notice: "Has inicado sesión"
    elsif employee.present? && employee.authenticate(params[:password])
      session[:user_type] = 1
      session[:user_id] = employee.employee_id
      redirect_to incidents_url, notice: "Has iniciado sesión"
    else
      flash.now.alert = "El mail o la clave esta incorrecta"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to root_url, notice: "Has cerrado sesión"
  end
end
