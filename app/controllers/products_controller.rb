class ProductsController < ApplicationController
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def show
    product = Product.find_by(store_id: params[:store_id], id: params[:id])
    if product
      render json: product, status: :ok
    else
      render json: { error: "No product found for store id #{params[:store_id]} and product id #{params[:id]}"}, status: :not_found
    end
  end

  def index
    products = Product.where(store_id: params[:store_id])
    if products.any?
      render json: products
    else
      render json: { error: "No products found for store with id #{params[:store_id]}"}, status: :not_found
    end
  end

  def update_inventory
    product = Product.find_by(store_id: params[:store_id], id: params[:id])
    if product
      product.update(product_params.merge(inventory_updated_time: Time.now))
      render json: product
    else
      render json: { error: "No product found for store with id #{params[:store_id]} and product id #{params[:id]} to update"}, status: :not_found
    end
  end

  private

  def product_params
    params.permit(:name, :sku, :inventory_quantity, :store_id)
  end
end
