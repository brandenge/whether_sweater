require 'rails_helper'

RSpec.describe ActivitiesFacade, type: :facades, vcr: { record: :new_episodes } do
  describe 'instance methods' do
    describe '#get_activities_for_weather' do
      it 'returns two activities appropriate for the weather' do
        actual = ActivitiesFacade.new.get_activities_for_weather(65)

        expect(actual).to be_an(Array)
        expect(actual.count).to eq(2)
      end
    end
  end
end
