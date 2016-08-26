def sign_up
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: "newuser@somewhere.com"
  fill_in 'Password', with: "12345678"
  fill_in 'Password confirmation', with: "12345678"
  click_button 'Sign up'
end

def sign_up_and_add_restaurant
  sign_up
  click_link 'Add a restaurant'
  fill_in "Name", with: 'KFC'
  click_button 'Create Restaurant'
end

def edit_restaurant
  click_link 'Edit KFC'
  fill_in 'Name', with: 'Kentucky Fried Chicken'
  fill_in 'Description', with: 'Deep fried goodness'
  click_button 'Update Restaurant'
end

def sign_up_different_user
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: "differentuser@somewhere.com"
  fill_in 'Password', with: "12345678"
  fill_in 'Password confirmation', with: "12345678"
  click_button 'Sign up'
end
