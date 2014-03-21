require 'spec_helper'

feature "Cookbook deletion", js: true do
  include Capybara::Angular::DSL

  scenario "is not allowed in All recipes cookbook" do
    user = create(:user, password: 'logMeIn')
    sign_in(user, 'logMeIn')
    click_link('All recipes')
    expect(page).to have_selector('button[disabled] > i.icon-trash')
  end

  scenario "deletes a cookbook" do
    user = create(:user, password: 'logMeIn')
    cookbook = create(:cookbook, user: user)
    sign_in(user, 'logMeIn')
    expect do
      click_link(cookbook.title)
      find('button > i.icon-trash').click
      expect(page).to have_content(
        'Your cookbook will be deleted. Are you sure you want to continue?'
      )
      click_link('Delete')
    end.to change{Cookbook.count}.by(-1)
  end
end