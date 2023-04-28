require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  describe 'POST #create' do
    subject! (:create_product) do
      post products_path(name: name, sku: sku, inventory_quantity: inventory_quantity, store_id: store_id)
    end

    before do
      create(:store)
    end

    context "with valid atrtibutes" do
      let(:name) {'My product'}
      let(:sku) {'1234'}
      let(:inventory_quantity) {'2'}
      let(:store) {create(:store)}
      let(:store_id) {store.id}

      it 'returns status ok' do
        expect(response).to have_http_status(:created)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'creates a new product' do
        expected_number_of_prodcuts = 1
        expect(Product.all.length).to equal(expected_number_of_prodcuts)
      end
    end

    context 'with invalid atrtibutes' do
      let(:name) {'My product'}
      let(:sku) {''}
      let(:inventory_quantity) {'2'}
      let(:store) {create(:store)}
      let(:store_id) {store.id}

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'does not create a new product' do
        expected_number_of_prodcuts = 0
        expect(Product.all.length).to equal(expected_number_of_prodcuts)
      end
    end
  end

  describe 'GET #index' do
    subject(:create_product) do
      get products_path(store_id: store_id)
    end

    before :each do
      store = create(:store)
      store2 = create(:store)
      create(:product, store_id: store.id)
      create(:product, store_id: store.id)
      create(:product, store_id: store.id)
      create(:product, store_id: store2.id)
      create_product
    end

    context 'with valid atrtibutes' do
      let(:store_id) {1}

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'get the products related to the id' do
        expected_number_of_prodcuts = 3
        expect(JSON.parse(response.body).length).to equal(expected_number_of_prodcuts)
      end
    end

    context "with invalid atrtibutes" do
      let(:store_id) { 50 }

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:not_found)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'does render error' do
        expected_number_of_prodcuts = 0
        expect(JSON.parse(response.body)['error']).to include("No products found for store with id #{store_id}")
      end
    end
  end

  describe 'GET #show' do
    subject(:create_product) do
      get product_path(store_id: store_id, id: product_id)
    end

    before :each do
      store = create(:store)
      create(:product, store_id: store.id)
      create_product
    end

    context "with valid atrtibutes" do
      let(:store_id) {1}
      let(:product_id) {1}

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'get the products related to the id' do
        expected_id_of_product = 1
        expect(JSON.parse(response.body)['id']).to equal(expected_id_of_product)
      end
    end

    context "with invalid atrtibutes" do
      let(:store_id) { 0 }
      let(:product_id) { 1 }

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:not_found)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'does render error' do
        expected_number_of_prodcuts = 0
        expect(JSON.parse(response.body)['error']).to include("No product found for store id #{store_id} and product id #{product_id}")
      end
    end
  end

  describe 'POST #update_inventory' do
    subject(:create_product) do
      post inventory_product_path(store_id: store_id, id: product_id, inventory_quantity: inventory_quantity)
    end

    before :each do
      store = create(:store)
      create(:product, store_id: store.id)
      create_product
    end

    context "with valid atrtibutes" do
      let(:store_id) {1}
      let(:product_id) {1}
      let(:inventory_quantity) {100}

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'updates product quantity' do
        expect(JSON.parse(response.body)['inventory_quantity']).to equal(inventory_quantity)
      end

      it 'updates inventory updated time' do
        expect(JSON.parse(response.body)['inventory_updated_time'] >= 1.hour.ago).to be_truthy
      end
    end

    context "with invalid atrtibutes" do
      let(:store_id) {1}
      let(:product_id) {0}
      let(:inventory_quantity) {100}

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:not_found)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'does render error' do
        expected_number_of_prodcuts = 0
        expect(JSON.parse(response.body)['error']).to include("No product found for store with id #{store_id} and product id #{product_id} to update")
      end
    end
  end
end