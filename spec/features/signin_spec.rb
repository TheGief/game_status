require 'spec_helper'

feature "Sign in" do
  let!(:user) { create(:han_solo) }

  scenario "Signing in with correct credentials" do
    visit login_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'Go!'
    page.should have_content('Logout')
    current_path.should eq(games_path)
  end

  scenario "Signing in with incorrect credentials" do
    visit login_path
    fill_in 'username', with: user.username
    fill_in 'password', with: "wrong_password"
    click_button 'Go!'
    page.should have_content('Invalid')
    current_path.should eq(sessions_path)
  end
end
