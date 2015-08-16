class Job < ActiveRecord::Base
	has_and_belongs_to_many :categories, -> { uniq }

	belongs_to :city_district

	reverse_geocoded_by "city_districts.latitude", "city_districts.longitude"


	def self.filter(category_ids, zipcode)
	 	if category_ids.any? && !zipcode.blank? 
	 		joins(:categories).joins(:city_district).where('categories.id'=>category_ids).near(zipcode,40, :units => :km)
	 	elsif category_ids.any?
	 		joins(:categories).where('categories.id'=>category_ids)
	 	elsif zipcode
	 		joins(:city_district).near(zipcode,40, :units => :km)
	 	else
	 		scoped
	 	end
	end

end
