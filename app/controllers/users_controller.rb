class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    begin
      id = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM users;")
      id.each do |row|
        id = row
      end
      id = id[0].to_i
      sql = "INSERT INTO users (user_id, name, mail, password_digest) VALUES ('#{id}', '#{@user.name}', '#{@user.mail}', '#{@user.password_digest}');"
      ActiveRecord::Base.connection.execute sql

      session[:user_id] = id
      session[:user_type] = 0
      redirect_to root_url, notice: "El usuario ha sido registrado"
    rescue 
      flash[:notice] = "Error en la forma"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :mail, :password, :password_confirmation)
  end
end

