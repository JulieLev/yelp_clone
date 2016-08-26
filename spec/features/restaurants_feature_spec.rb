require 'rails_helper'

feature 'Feature - restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display there are no restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'option to add a restaurant displayed' do
    scenario 'user is not signed in' do
        visit '/'
        expect(page).not_to have_link 'Add a restaurant'
    end

    scenario 'user is signed in' do
      sign_up
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts signed in user to fill out a form, then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'does not let user submit a name that is too short' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){ Restaurant.create(name: 'KFC') }

    scenario 'let a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before do
      sign_up_and_add_restaurant
    end

    scenario 'let a signed in user edit their own restaurant' do
      edit_restaurant
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Deep fried goodness'
    end

    scenario "does not let a signed in user edit another user's restaurant" do
      click_link 'Sign out'
      sign_up_different_user
      click_link 'Edit KFC'
      expect(page).to have_content("You are not allowed to edit another user's restaurant")
      expect(page).not_to have_content 'Deep fried goodness'
    end
  end

context 'deleting restaurants' do
  before do
    sign_up_and_add_restaurant
  end

  scenario 'let a signed in user delete their own restaurant' do
    click_link 'Delete KFC'
    expect(page).not_to have_content('KFC')
    expect(page).to have_content('Restaurant deleted successfully')
    expect(current_path).to eq '/restaurants'
  end

  scenario "does not let a signed in user delete another user's restaurant" do
    click_link 'Sign out'
    sign_up_different_user
    click_link 'Delete KFC'
    expect(page).to have_content("You are not allowed to delete another user's restaurant")
    expect(page).to have_content 'KFC'
  end

end

end
