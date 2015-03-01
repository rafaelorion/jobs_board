json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :premium , :description
  json.url job_url(job, format: :json)
end
