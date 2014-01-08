require 'spec_helper'

  describe 'User signup' do
    it 'signup' do
      user_count = User.count
      page.visit new_user_path
      fill_in 'Email', :with => "trippytripster@example.com"
      fill_in 'Name',   :with => "The Trippiest"
      # avatar test
      click_on 'Sign Up'
      page.should have_content("Logout")

      expect(User.count).to eq user_count + 1
    end  
  end
