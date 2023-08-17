class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_create_message;
rescue_from ActiveRecord::RecordNotFound, with: :plant_not_found_message;
wrap_parameters format: [];

    def index
        plants = Plant.all
        render json: plants
    end

    def show
        plant = find_plant
        render json: plant
    end

    def create
        if !Plant.find_by name: params[:name]
            plant = Plant.create!(plant_params)
            render json: plant, status: :created
        else
            plant = Plant.find_by name: params[:name]
            render json: {error:"Plant name already exists with the index: #{plant.id}"}, status: :conflict
        end
    end

    def update
        plant = find_plant
        plant.update(plant_params)
        render json: plant, status: :accepted
    end

    def destroy
        plant = find_plant
        plant.destroy
        head :ok
    end


    private

    def plant_params
        params.permit(:name, :category, :image, :description, :price, :quantity)
    end

    def find_plant
        Plant.find(params[:id])
    end
    
    def invalid_create_message invalid
        render json: {error: invalid.record.errors.full_messages}, status: 422
    end

    def plant_not_found_message
        render json: {error: "Plant could not be found."}
    end
end
