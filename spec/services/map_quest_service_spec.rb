require 'rails_helper'

RSpec.describe MapQuestService, type: :service, vcr: { record: :new_episodes } do
  subject(:map_quest_service) { MapQuestService.new }

  describe 'instance methods' do
    describe '#get_city_lat_lon' do
      it "returns the latitude and longitude coordinates of a city" do
        expected = {
          lat: 39.74001,
          lng: -104.99202
        }
        expect(map_quest_service.get_city_lat_lng('denver', 'co'))
          .to eq(expected)
      end
    end
  end
end
