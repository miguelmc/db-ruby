class IncidentsController < ApplicationController
  before_action :has_to_authenticate
  before_action :set_incident, only: [:show, :edit, :update, :destroy]


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
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)


    begin
      id = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM incidents;")
      id.each do |row|
        id = row
      end
      id = id[0].to_i
      sql = "INSERT INTO incidents (incident_id, u_id, descripcion, tipo, prioridad) VALUES ('#{id}', '#{session[:user_id]}', '#{@incident.descripcion}', '#{@incident.tipo}', '#{@incident.prioridad}');"
      ActiveRecord::Base.connection.execute sql

      redirect_to root_url, notice: "Gracias, el incidente será revisado"
    rescue 
      flash[:notice] = "Error en la forma"
      render :new
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    begin
      incident_params = params[:incident]
      sql = "UPDATE incidents SET tipo = '#{incident_params["tipo"]}', descripcion = '#{incident_params["descripcion"]}', prioridad = '#{incident_params["prioridad"]}', estado = 'CERRADO' WHERE incident_id = #{@incident.incident_id};"

      ActiveRecord::Base.connection.execute sql

      redirect_to incident_url(@incident), notice: "El incidente ha sido modificado con exito."
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
