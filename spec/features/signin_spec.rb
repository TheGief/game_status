require 'spec_helper'

feature "Sign in" do
  let!(:user) { create(:han_solo) }

  scenario "Signing in with correct credentials" do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'
    page.should have_content('Logout')
    current_path.should eq(friends_path)
  end

  scenario "Signing in with incorrect credentials" do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: "wrong_password"
    click_button 'Sign in'
    page.should have_content('Invalid')
    current_path.should eq(new_user_session_path)
  end
end
