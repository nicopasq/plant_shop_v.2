class PlantsController < ApplicationController
wrap_parameters format: [];

    def index
        plants = Plant.all
        render json: plants
    end

    def create
        plant = Plant.create(plant_params)
        render json: plant, status: :created
    end

    private

    def plant_params
        params.permit(:name, :category, :image, :description, :price, :quantity)
    end
end
