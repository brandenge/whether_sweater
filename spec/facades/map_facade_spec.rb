require 'rails_helper'

RSpec.describe MapFacade, vcr: { record: :new_episodes } do
  subject(:map_facade) { MapFacade.new }

  describe 'instance methods' do
    describe '#get_city_lat_lng' do
      context 'Happy path - valid and found city and state location' do
        it "returns the latitude and longitude coordinates of a city" do
          expected = {
            lat: 38.89037,
            lng: -77.03196
          }
          expect(map_facade.get_city_lat_lng('washington,dc'))
            .to eq(expected)
        end
      end

      context 'Sad paths - invalid request' do
        it 'returns a custom error for an invalid location' do
          expect { map_facade.get_city_lat_lng('Ggeim,FG') }
            .to raise_error(CustomError)
          begin
            map_facade.get_city_lat_lng('Ggeim,FG')
          rescue CustomError => e
            expect(e.message).to eq('No location found. Please provide a known location query parameter.')
            expect(e.status).to eq(400)
          end
        end
      end
    end
  end
end
