require 'rails_helper'

RSpec.describe LocationFacade, type: :facades, vcr: { record: :new_episodes } do
  describe 'instance methods' do
    describe '#get_city_lat_lng' do
      context 'Sad path - invalid city and state location' do
        it 'returns a custom error for an invalid location' do
          expect { LocationFacade.new.get_city_lat_lng('#@$O@#(%)') }
            .to raise_error(CustomError)
            begin
              LocationFacade.new.get_city_lat_lng('Ggeim,FG')
            rescue CustomError => e
              expect(e.message).to eq('Invalid location. Please provide a valid city and state location.')
              expect(e.status).to eq(400)
            end
        end
      end

      context 'Sad path - city and state location not found' do
        it 'returns a custom error for a location not found' do
          expect { LocationFacade.new.get_city_lat_lng('Ggeim,FG') }
            .to raise_error(CustomError)
          begin
            LocationFacade.new.get_city_lat_lng('Ggeim,FG')
          rescue CustomError => e
            expect(e.message).to eq('No location found. Please provide a known location query parameter.')
            expect(e.status).to eq(400)
          end
        end
      end

      context 'Happy path - valid and found city and state location' do
        it "returns the latitude and longitude coordinates of a city" do
          expected = {
            lat: 38.89037,
            lng: -77.03196
          }
          expect(LocationFacade.new.get_city_lat_lng('washington,dc'))
            .to eq(expected)
        end
      end
    end
  end
end
