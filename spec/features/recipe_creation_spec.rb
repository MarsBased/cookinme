require 'spec_helper'

feature "Recipe creation", js: true do
  include Capybara::Angular::DSL

  scenario "on all recipes" do
    user = create(:user, password: 'logMeIn')
    sign_in(user, 'logMeIn')
    click_link("All recipes")
    expect do
      find('.navbar').click_link('Recipe')
      expect(page).to have_selector('.sideBox.recipe')
    end.to change{user.recipes.count}.by(1)
  end

   scenario "inside a cookbook" do
    user = create(:user, password: 'logMeIn')
    cookbook = create(:cookbook, user: user)
    sign_in(user, 'logMeIn')
    click_link(cookbook.title)
    expect do
      find('.navbar').click_link('Recipe')
      expect(page).to have_selector('.sideBox.recipe')
    end.to change{cookbook.recipes.count}.by(1)
  end
end