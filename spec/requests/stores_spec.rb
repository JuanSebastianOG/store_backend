require 'rails_helper'

RSpec.describe StoresController, type: :request do
  describe 'POST #create' do
    subject! (:create_store) do
      post stores_path({name: name, url: url})
    end

    context "with valid atrtibutes" do
      let(:name) {'My stori'}
      let(:url) {'mystori.com'}
      it 'returns status ok' do
        expect(response).to have_http_status(:created)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'creates a new store' do
        expected_number_of_stores = 1
        expect(Store.all.length).to equal(expected_number_of_stores)
      end
    end

    context "with invalid atrtibutes" do
      let(:name) {'My stori'}
      let(:url) {''}
      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should response with json' do
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      end

      it 'does not create a new store' do
        expected_number_of_stores = 0
        expect(Store.all.length).to equal(expected_number_of_stores)
      end
    end
  end
end
