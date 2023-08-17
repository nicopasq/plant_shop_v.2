class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_create_message;
wrap_parameters format: [];

    def index
        plants = Plant.all
        render json: plants
    end

    def create
        plant = Plant.create!(plant_params)
        render json: plant, status: :created
    end


    private

    def plant_params
        params.permit(:name, :category, :image, :description, :price, :quantity)
    end
    
    def invalid_create_message invalid
        render json: {error: invalid.record.errors.full_messages}, status: 422
    end
end
