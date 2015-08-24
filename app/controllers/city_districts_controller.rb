class CityDistrictsController < ApplicationController
  def index
    render json: CityDistrict.terms_for(params[:term])
  end
end
