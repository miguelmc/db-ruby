class IncidentsController < ApplicationController
  before_action :has_to_authenticate
  before_action :set_incident, only: [:show, :edit, :assign, :close, :update, :destroy]


  # GET /incidents
  # GET /incidents.json
  def index
    if session[:user_type] == 0
      @incidents = Incident.find_by_sql("SELECT * FROM incidents WHERE u_id = #{current_user.user_id} ORDER BY fecha_inicio;")
    else
      @incidents = Incident.find_by_sql("SELECT * FROM incidents ORDER BY fecha_inicio;")
    end
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
    if @incident.encargado.nil?
      @encargado = nil
    else
      @encargado = Employee.find_by_sql("SELECT * from employees WHERE employee_id = #{@incident.encargado};")[0]
    end
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
    @catalogList = [['Tecnologia/Proyectores',1], ['Plomeria/Tuberias',2], ['Logistica/Bancos', 3], ['Tecnologia/IT',4]]
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)
    @catalogList = [['Tecnologia/Proyectores',1], ['Plomeria/Tuberias',2], ['Logistica/Bancos', 3], ['Tecnologia/IT',4]]

    begin
      id = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM incidents;")
      id.each do |row|
        id = row
      end
      id = id[0].to_i + 1
      sql = "INSERT INTO incidents (incident_id, u_id, descripcion, prioridad, fecha_inicio, catalog) VALUES ('#{id}', '#{session[:user_id]}', '#{@incident.descripcion}', '#{@incident.prioridad}', #{Time.now.strftime("%Y%m%d").to_i}, '#{@incident.catalog}');"
      ActiveRecord::Base.connection.execute sql

      redirect_to incidents_url, notice: "Gracias, el incidente será revisado"
    rescue 
      flash[:notice] = "Error en la forma"
      render :new
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def close 
    begin
      sql = "UPDATE incidents SET estado = 'CERRADO', fecha_final = #{Time.now.strftime("%Y%m%d").to_i} WHERE incident_id = #{@incident.incident_id};"

      ActiveRecord::Base.connection.execute sql
      redirect_to incident_path(@incident), notice: "El incidente ha sido modificado con exito."
    rescue
      flash[:notice] = "Alguna alteracion no fue correctamente modificada"
      render :edit
    end
  end

  def update
    begin
      sql = "UPDATE incidents SET estado = 'ABIERTO', encargado = NULL WHERE incident_id = #{@incident.incident_id};"

      ActiveRecord::Base.connection.execute sql

      redirect_to incident_attempts_url(@incident), notice: "El incidente ha sido modificado con exito."
    rescue
      flash[:notice] = "Alguna alteracion no fue correctamente modificada"
      render :edit
    end
  end

  def assign 
    begin
      sql = "UPDATE incidents SET estado = 'OCUPADO', encargado = #{session[:user_id]} WHERE incident_id = #{@incident.incident_id};"

      ActiveRecord::Base.connection.execute sql

      redirect_to create_attempt_path(@incident), notice: "El incidente ha sido modificado con exito."
    rescue
      flash[:notice] = "Alguna alteracion no fue correctamente modificada"
      render :edit
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    begin
      sql = "DELETE FROM incidents WHERE incident_id = #{@incident.incident_id};"
      ActiveRecord::Base.connection.execute sql
    rescue
      flash[:notice] = "Something bad happened"
    end
    redirect_to incidents_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_incident
    @incident = Incident.find_by_sql("SELECT * FROM incidents WHERE incident_id =#{params[:id]};" )[0]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def incident_params
    params.require(:incident).permit(:tipo, :descripcion, :prioridad)
  end
end
