class StoresController < ApplicationController
  def create
    store = Store.new(store_params)
    if store.save
      render json: store, status: :created
    else
      render json: store.errors, status: :unprocessable_entity
    end
  end

  private

  def store_params
    params.permit(:name, :url)
  end
end
