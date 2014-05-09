class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
  end
  def create
    @employee = Employee.new(employee_params)
    begin
      id = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM employees;")
      id.each do |row|
        id = row
      end
      id = id[0].to_i
      sql = "INSERT INTO employees (employee_id, name, mail, password_digest) VALUES ('#{id}', '#{@employee.name}', '#{@employee.mail}', '#{@employee.password_digest}');"
      ActiveRecord::Base.connection.execute sql

      session[:user_id] = id
      session[:user_type] = 0
      redirect_to root_url, notice: "El empleado ha sido registrado"
    rescue 
      flash[:notice] = "Error en la forma"
      render :new
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :mail, :password, :password_confirmation)
  end
end

