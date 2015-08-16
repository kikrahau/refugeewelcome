class AddCityDistrictToJobs < ActiveRecord::Migration
  def change
    add_reference :jobs, :city_district, index: true, foreign_key: true
  end
end
