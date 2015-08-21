class CityDistrict < ActiveRecord::Base
	has_many :city_district
	
	geocoded_by :address
	after_validation :geocode, if: ->(obj){ obj.zip.present? and obj.zip_changed? and !obj.coordinates.any? }

	def address
		"#{zip} #{name},Germany"
	end

	def coordinates
		[latitude,longitude]
	end

end
