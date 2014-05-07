json.array!(@incidents) do |incident|
  json.extract! incident, :id, :tipo, :descripcion, :prioridad
  json.url incident_url(incident, format: :json)
end
