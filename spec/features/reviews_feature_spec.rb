require 'rails_helper'

feature 'Feature - reviews' do
  before { sign_up_and_add_restaurant }
  let (:kfc) { Restaurant.find_by_name('KFC') }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '***', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content("so so")
  end

  scenario 'allows user to delete their own review' do
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '***', from: 'Rating'
    click_button 'Leave Review'
    click_link 'KFC'
    click_link 'Delete Review'

    expect(page).not_to have_content('so so')
    expect(current_path).to eq "/restaurants/#{kfc.id}"
  end

  scenario "does not allow user to delete another user's review" do
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '***', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Sign out'
    sign_up('different@somewhere.com', '123456')
    click_link 'KFC'
    expect(page).not_to have_content 'Delete Review'
  end
  #
  #   click_link 'Review KFC'
  #   fill_in "Thoughts", with: "so so"
  #   select '***', from: 'Rating'
  #   click_button 'Leave Review'
  #   expect(current_path).to eq '/restaurants'
  #   expect(page).to have_content 'so so'
  # end
end
