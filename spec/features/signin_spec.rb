require 'spec_helper'

feature "Sign in" do

  background do
    @user = FactoryGirl.create(:han_solo)
  end

  scenario "Signing in with correct credentials" do
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'Go!'
    page.should have_content('Logout')
    current_path.should eq(root_path)
  end

  scenario "Signing in with incorrect credentials" do
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: "wrong_password"
    click_button 'Go!'
    page.should have_content('Invalid')
    current_path.should eq(sessions_path)
  end

end
