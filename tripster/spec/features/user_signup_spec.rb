require 'spec_helper'

  describe 'User signup' do
    visit new_user_path
    fill_in 'Email', :with => "trippytripster@example.com"
    fill_in 'Name', :with => "The Trippiest"
    # avatar test
    click_on 'Sign Up'
    expect(page).to have_content('Connect') 
  end
