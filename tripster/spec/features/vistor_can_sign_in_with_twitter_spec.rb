require 'spec_helper'

describe 'visitor can sign in with twitter' do

  it 'when clicking on the login in button' do
    visit root_path
    click_on 'Sign in with Twitter'
    expect(page).to have_content 'rolen'
  end
end

