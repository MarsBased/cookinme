require 'spec_helper'

feature 'Cookbook recipe update', js: true do
  include Capybara::Angular::DSL

  scenario "updates the cookbook when no cookbook is set" do
    guybrush = create(:user, password: 'logMeIn')
    cookbook = create(:cookbook, user: guybrush)
    recipe = create(:recipe, user: guybrush, cookbook: nil)
    sign_in(guybrush, 'logMeIn')
    click_link('All recipes')
    click_link(recipe.title)
    within('.sideBox.recipe') { click_link('Cookbook') }
    within('#moveCookbook') { click_link(cookbook.title) }
    click_link('My Cookbooks')
    click_link(cookbook.title)
    expect(page).to have_content(recipe.title)
    expect(recipe.reload.cookbook).to eq(cookbook)
  end

  scenario "updates the cookbook when the recipe had a cookbook" do
    guybrush = create(:user, password: 'logMeIn')
    first_cookbook = create(:cookbook, user: guybrush, title: 'Cocktails')
    second_cookbook = create(:cookbook,
      user: guybrush,
      title: 'Pirate Cocktails'
    )
    recipe = create(:recipe, user: guybrush, cookbook: first_cookbook)
    sign_in(guybrush, 'logMeIn')
    click_link('Cocktails')
    click_link(recipe.title)
    within('.sideBox.recipe') { click_link('Cookbook') }
    within('#moveCookbook') { click_link(second_cookbook.title) }
    click_link('My Cookbooks')
    click_link('Pirate Cocktails')
    expect(page).to have_content(recipe.title)
    expect(recipe.reload.cookbook).to eq(second_cookbook)
  end

  scenario "removes the cookbook when changing to all recipes" do
    guybrush = create(:user, password: 'logMeIn')
    cookbook = create(:cookbook, user: guybrush)
    recipe = create(:recipe, user: guybrush, cookbook: cookbook)
    sign_in(guybrush, 'logMeIn')
    click_link(cookbook.title)
    click_link(recipe.title)
    within('.sideBox.recipe') { click_link('Cookbook') }
    within('#moveCookbook') { click_link('All recipes') }
    expect(page).to have_content('All recipes')
    expect(recipe.reload.cookbook).to eq(nil)
  end
end