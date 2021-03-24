class CitiesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:current]
    before_action :skip_authorization, only: [:current]

    def current
        city = City.find_by(name: "Nantes")

        render json: city
    end
end
