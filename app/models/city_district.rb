class CityDistrict < ActiveRecord::Base

	geocoded_by :address
	after_validation :geocode, if: ->(obj){ obj.zip.present? and obj.zip_changed? }

	def address
		"#{zip} #{name},Germany"
	end

end
