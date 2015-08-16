class Category < ActiveRecord::Base
	has_and_belongs_to_many :users, -> { uniq }
	has_and_belongs_to_many :jobs, -> { uniq }
	
end
