class AddAddressFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :street, :string
    add_column :users, :city_district_id, :integer
  end
end
