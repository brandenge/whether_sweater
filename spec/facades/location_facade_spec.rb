require 'rails_helper'

RSpec.describe LocationFacade, vcr: { record: :new_episodes } do
  subject(:location_facade) { LocationFacade.new }

  describe 'instance methods' do
    describe '#get_city_lat_lng' do
      context 'Happy path - valid and found city and state location' do
        it "returns the latitude and longitude coordinates of a city" do
          expected = {
            lat: 38.89037,
            lng: -77.03196
          }
          expect(location_facade.get_city_lat_lng('washington,dc'))
            .to eq(expected)
        end
      end

      context 'Sad paths - invalid request' do
        it 'returns a custom error for an invalid location' do
          expect { location_facade.get_city_lat_lng('#@$O@#(%)') }
            .to raise_error(CustomError)
          begin
            location_facade.get_city_lat_lng('#@$O@#(%)')
          rescue CustomError => e
            expect(e.message).to eq('Invalid location. Please provide a valid city and state location.')
            expect(e.status).to eq(400)
          end
        end

        it 'returns a custom error for a location not found' do
          expect { location_facade.get_city_lat_lng('Ggeim,FG') }
            .to raise_error(CustomError)
          begin
            location_facade.get_city_lat_lng('Ggeim,FG')
          rescue CustomError => e
            expect(e.message).to eq('No location found. Please provide a known location query parameter.')
            expect(e.status).to eq(400)
          end
        end
      end
    end
  end
end
