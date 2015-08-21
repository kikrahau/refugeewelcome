class AddIndexToCityDistrict < ActiveRecord::Migration
  def change
    add_index :city_districts, :zip
  end
end
