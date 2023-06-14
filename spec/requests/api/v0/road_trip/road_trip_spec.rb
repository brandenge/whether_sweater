require 'rails_helper'

RSpec.describe 'Road Trip', type: :request, vcr: { record: :new_episodes } do
  context 'Happy path - valid request' do
    it 'returns a road trip' do
      post api_v0_road_trip_path({
        origin: 'Cincinatti,OH',
        destination: 'Chicago,IL',
        api_key: 't1h2i3s4_i5s6_l7e8g9i10t11'
      })

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a(Hash)
      expect(user.keys.count).to eq(1)
      expect(user).to have_key(:data)

      data = road_trip[:data]
      expect(data).to be_a(Hash)
      expect(data.keys.count).to eq(3)
      expect(data).to have_key(:id)
      expect(data).to have_key(:type)
      expect(data).to have_key(:attributes)

      expect(data[:id]).to eq(nil)
      expect(data[:type]).to be_a(String)
      expect(data[:type]).to eq('road_trip')

      expect(data[:attributes]).to be_a(Hash)
      expect(data[:attributes].keys.count).to eq(4)
      expect(data[:attributes]).to have_key(:start_city)
      expect(data[:attributes]).to have_key(:end_city)
      expect(data[:attributes]).to have_key(:travel_time)
      expect(data[:attributes]).to have_key(:weather_at_eta)

      attributes = data[:attributes]
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes[:travel_time]).to be_a(String)
      expect(attributes[:weather_at_eta]).to be_a(Hash)

      weather_at_eta = attributes[:weather_at_eta]
      expect(weather_at_eta.keys.count).to eq(3)
      expect(weather_at_eta).to have_key(:datetime)
      expect(weather_at_eta).to have_key(:temperature)
      expect(weather_at_eta).to have_key(:condition)

      expect(weather_at_eta[:datetime]).to be_a(String)
      expect(weather_at_eta[:temperature]).to be_a(Numeric)
      expect(weather_at_eta[:condition]).to be_a(String)
    end
  end

  context 'Sad path - invalid or missing api key' do
    it 'returns an error message when the api key is missing' do
      post api_v0_road_trip_path({
        origin: 'Cincinatti,OH',
        destination: 'Chicago,IL'
      })

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      check_valid_error_response(error)

      expect(error[:errors].first[:detail]).to eq('Invalid request. The API key is missing or invalid.')
    end

    it 'returns an error message when the api key is invalid' do
      post api_v0_road_trip_path({
        origin: 'Cincinatti,OH',
        destination: 'Chicago,IL',
        api_key: 'abc123'
      })

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      check_valid_error_response(error)

      expect(error[:errors].first[:detail]).to eq('Invalid request. The API key is missing or invalid.')
    end
  end
end
