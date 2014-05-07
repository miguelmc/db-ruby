class IncidentsController < ApplicationController
  before_action :has_to_authenticate
  before_action :set_incident, only: [:show, :edit, :update, :destroy]


  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = Incident.all
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

      redirect_to root_url, notice: "Gracias, si incidente será revisado"
    rescue 
      flash[:notice] = "Error en la forma"
      render :new
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_incident
    @incident = Incident.find_by_sql("SELECT * FROM incidentes WHERE incident_id ='#{params[id]}';" )
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def incident_params
    params.require(:incident).permit(:tipo, :descripcion, :prioridad)
  end
end
