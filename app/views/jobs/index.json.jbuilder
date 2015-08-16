json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :text
  json.url job_url(job, format: :json)
	json.location do
		json.zip_code job.city_district.zip
		json.city job.city_district.name
	end
end