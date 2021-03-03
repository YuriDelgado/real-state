require 'rails_helper'

RSpec.describe Api::V1::RealstatesController do
  let!(:real_states) { create_list(:realstate, 10) }

  context "GET index" do
    before do
      get :index, format: :json
    end

    it 'return 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it "JSON body response contains expected realstates list" do
      expect(response.body.include?(real_states.first.name)).to eq(true)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(10)
      expect(json_response.first.keys).to match_array(%w[id name category city country])
    end
  end

  context "GET show" do
    let!(:real_state) { real_states.sample }

    before do
      get :show, params: { id: real_state.id }, format: :json
    end

    it "JSON body response contains expected realstate record" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(%w[id name category street external_number internal_number neighborhood city country rooms bathrooms comments])
      expect(json_response['name']).to eq(real_state.name)
      expect(json_response['street']).to eq(real_state.street)
    end
  end
end

