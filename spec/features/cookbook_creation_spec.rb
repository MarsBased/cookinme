require 'spec_helper'

feature 'Cookbook creation', js: true do
  include Capybara::Angular::DSL

  scenario "creates a new cookbook with the default title" do
    user = create(:user, password: 'logMeIn')
    sign_in(user, 'logMeIn')
    expect(page).to have_selector('.cookbook', count: 1)

    expect do
      within('.navbar') do
        click_link("Cookbook")
      end
      expect(page).to have_content('Your new cookbook')
    end.to change{user.cookbooks.count}.by(1)

    click_link('My Cookbooks')
    expect(page).to have_selector('.cookbook', count: 2)
    expect(page).to have_content('Your new cookbook')
  end
end