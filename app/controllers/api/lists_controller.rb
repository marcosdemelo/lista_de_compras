class Api::ListsController < ApplicationController
  def index
    render json: List.all
  end

  def new
    render json: List.new
  end

  def show
    render json: List.find(params[:id])
  end

  def create
    list = List.new(filtered_params)

    if list.save
      render json: list, status: :created
    else
      render json: list.errors, status: :unprocessable_entity
    end
  end

  def update
    list = List.find(params[:id])

    if list.update(filtered_params)
      render json: list
    else
      render json: list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    list = List.find(params[:id])

    if list.destroy
      render json: list
    else
      render json: list.errors, status: :unprocessable_entity
    end
  end

  def filtered_params
    params.require(:list).permit(:name, list_items_attributes: [:id, :list_id,
      :product_id, :quantity, :_destroy])
  end
end
