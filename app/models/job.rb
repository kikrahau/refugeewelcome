class Job < ActiveRecord::Base
	has_and_belongs_to_many :categories, -> { uniq }
	belongs_to :city_district
	reverse_geocoded_by "city_districts.latitude", "city_districts.longitude"

	def self.filter(category_ids, city)
	 	if category_ids.any? && city 
	 		joins(:categories).joins(:city_district).where('categories.id'=>category_ids).near(city.coordinates,40, :units => :km)
	 	elsif category_ids.any?
	 		joins(:categories).where('categories.id'=>category_ids)
	 	elsif city
	 		joins(:city_district).near(city.coordinates,40, :units => :km)
	 	else
	 		all
	 	end
	end

end
