json.array!(@attempts) do |attempt|
  json.extract! attempt, :id, :comentario
  json.url attempt_url(attempt, format: :json)
end
