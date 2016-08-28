require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many :restaurants}
  it { is_expected.to have_many :reviews }
  it { is_expected.to have_many :reviewed_restaurants }

  describe 'Restaurants' do
    let(:user) { User.create email: 'test@test.com', password: '123456', password_confirmation: '123456' }
    let(:restaurant_params) { {name: 'Diner'} }

    subject(:restaurant) {
    user.restaurants.create(restaurant_params) }

    it 'creates a restaurant' do
      expect(restaurant).to be_a Restaurant
    end

    it 'creates a restaurant associated with the specific user' do
      expect(restaurant.user).to eq user
    end
  end
end
