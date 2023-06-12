require 'rails_helper'

RSpec.describe MapQuestService, type: :services, vcr: { record: :new_episodes } do
  describe 'instance methods' do
    describe '#get_city_lat_lon' do
      it "returns the latitude and longitude coordinates of a city" do
        expected = {
          lat: 38.89037,
          lng: -77.03196
        }
        expect(MapQuestService.new.get_city_lat_lon('Washington', 'DC'))
          .to eq(expected)
      end
    end
  end
end
