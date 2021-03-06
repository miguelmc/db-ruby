class AttemptsController < ApplicationController
  before_action :has_to_authenticate, except: [:index]

  # GET /attempts
  # GET /attempts.json
  def index
    @incident = Incident.find_by_sql("SELECT * FROM incidents where incident_id = #{params[:incident_id]}")[0]
    if session[:user_type] == 1
      #Encontrar todos los attempts hechos por el empleado
      @attempts = Attempt.find_by_sql("SELECT * FROM attempts a WHERE i_id = #{@incident.incident_id } and comentario != '' ORDER BY fecha_inicio;")
    else
      #Encontrar todos los attempts encontrados en los incidentes que el usuario actual creó.
      @attempts = Attempt.find_by_sql("SELECT incident_id, attempt_id, e_id, u_id, encargado, catalog, comentario, descripcion, a.fecha_inicio, a.fecha_final, estado, prioridad FROM attempts a, incidents i WHERE a.i_id = i.incident_id and i.u_id = #{current_user.user_id} and comentario != '' ORDER BY a.fecha_inicio;")
    end
  end
 
  def index_employee
    if session[:user_type] == 1
      #Encontrar todos los attempts hechos por el empleado
      @attempts = Attempt.find_by_sql("SELECT * FROM attempts ORDER BY fecha_inicio;")
    else
      redirect_to incidents_path, notice: "No tienes permiso de ver esta pagina."
    end
  end

  # GET /attempts/1
  # GET /attempts/1.json
  def show
    @incident = Incident.find_by_sql("SELECT * FROM incidents where incident_id = #{params[:incident_id]}")[0]
    @attempt = Attempt.find_by_sql("SELECT * FROM attempts WHERE attempt_id =#{params[:id]};")[0]
    @employee = Employee.find_by_sql("SELECT * FROM employees WHERE employee_id = #{@attempt.e_id};")[0]
  end

  # GET /attempts/new
  def new
    @incident = Incident.find_by_sql("SELECT * FROM incidents where incident_id = #{params[:incident_id]}")[0]
    @attempt = Attempt.new
  end

  # POST /attempts
  # POST /attempts.json
  def create
    @incident = Incident.find_by_sql("SELECT * FROM incidents where incident_id = #{params[:id]}")[0]

    begin
      id = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM attempts;")
      id.each do |row|
        id = row
      end
      id = (id[0].to_i) + 1
      sql = "INSERT INTO attempts (attempt_id, e_id, i_id, fecha_inicio, comentario) VALUES ('#{id}', '#{session[:user_id]}', #{@incident.incident_id}, #{Time.now.strftime("%Y%m%d").to_i}, '');"
      ActiveRecord::Base.connection.execute sql

      redirect_to incident_path(@incident), notice: "¡Gracias!"
    rescue 
      flash[:notice] = "Error en la forma"
      render :new
    end
  end

  def edit
    @incident = Incident.find_by_sql("SELECT * FROM incidents where incident_id = #{params[:incident_id]}")[0]
    @attempt = Attempt.find_by_sql("SELECT * FROM attempts WHERE attempt_id = #{params[:id]}")[0]
  end

  def update
    @incident = Incident.find_by_sql("SELECT * FROM incidents where incident_id = #{params[:incident_id]}")[0]
    @attempt = Attempt.new(attempt_params)
    begin
      sql = "UPDATE attempts SET fecha_final = #{Time.now.strftime("%Y%m%d").to_i}, comentario = '#{@attempt.comentario}' WHERE i_id = #{@incident.incident_id} and comentario = '';"

      ActiveRecord::Base.connection.execute sql

      redirect_to incident_update_path(@incident), notice: "El incidente ha sido modificado con exito."
    rescue
      flash[:notice] = "Alguna alteracion no fue correctamente modificada"
      render :edit
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attempt
    debugger
    @incident = Incident.find_by_sql("SELECT * FROM incidents where incident_id = #{params[:incident_id]}")[0]
    @attempt = Attempt.find_by_sql("SELECT * FROM attempts WHERE attempt_id =#{params[:id]};")[0]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attempt_params
    params.require(:attempt).permit(:comentario)
  end
end
