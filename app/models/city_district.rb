class CityDistrict < ActiveRecord::Base

	has_many :jobs
	
	geocoded_by :address
	after_validation :geocode, if: ->(obj){ obj.zip.present? and obj.zip_changed? and !obj.coordinates.any? }

	def address
		"#{zip} #{name},Germany"
	end

	def coordinates
		[latitude,longitude]
	end

	def self.terms_for(prefix)
		$redis.zrevrange "zip:#{prefix}",0,4
	end

	def self.index_city_districts
		CityDistrict.find_each do |city|
			index_term(city.name)
			index_term(city.zip.to_s)
			city.name.split.each {|t| index_term t }
		end
	end

	def self.index_term(term)
		1.upto(term.length-1) do |n|
			prefix = term[0,n]
			$redis.zincrby "zip:#{prefix}",1, term.downcase 
		end
	end

end
