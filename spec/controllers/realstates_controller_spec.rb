require 'rails_helper'

RSpec.describe Api::V1::RealstatesController do
  let!(:real_states) { create_list(:realstate, 10) }
  let(:params_full_list) { %w[id name category street external_number internal_number neighborhood city country rooms bathrooms comments] }
  let(:params_index_list) { %w[id name category city country] }

  context 'GET index' do
    before do
      get :index, format: :json
    end

    it 'return 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'JSON body response contains expected realstates list' do
      expect(response.body.include?(real_states.first.name)).to eq(true)

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(10)
      expect(json_response.first.keys).to match_array(params_index_list)
    end
  end

  context 'GET show' do
    let!(:real_state) { real_states.sample }

    before do
      get :show, params: { id: real_state.id }, format: :json
    end

    it 'JSON body response contains expected realstate record' do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(params_full_list)
      expect(json_response['name']).to eq(real_state.name)
      expect(json_response['street']).to eq(real_state.street)
    end
  end

  context 'POST create realstate' do
    let!(:real_state) { build(:realstate) }

    it 'with valid should return a new JSON object' do
      expect {
        post :create, params: { real_state: real_state.attributes.except("id") }, format: :json
      }.to change{Realstate.count}.by(1)
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(params_full_list)
      expect(json_response['id']).to_not be_nil
    end
  end

  context 'PATCH update realstate' do
    let!(:real_state) { real_states.sample }

    before do
      real_state.name = 'this should be modified'
      patch :update, params: { id: real_state.id, real_state: real_state.attributes.except("id") }, format: :json
    end

    it 'with valid should return a new JSON object' do
      expect(response.body).to include('this should be modified')
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(params_full_list)
    end
  end

  context 'DELETE destroy realstate' do
    let!(:real_state) { real_states.sample }

    it 'should remove the selected object and return JSON object' do
      expect{
        delete :destroy, params: { id: real_state.id }, format: :json
      }.to change{Realstate.count}.by(-1)

      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(params_full_list)
      expect(Realstate.where(id: json_response['id']).count).to be(0)
    end
  end
end
