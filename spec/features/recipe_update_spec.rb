require 'spec_helper'

feature "Recipe update", js: true do
  include Capybara::Angular::DSL

  scenario "updates the title of a recipe" do
    guybrush = create(:user, password: 'logMeIn')
    recipe = create(:recipe, user: guybrush, title: 'San Francisco')
    sign_in(guybrush, 'logMeIn')
    click_link('All recipes')
    click_link(recipe.title)
    within('.sideBox.recipe .sideBox-title') do
      find('input').set('Grog')
      find('input').native.send_keys(:return)
    end
    click_link("My Cookbooks")
    click_link("All recipes")
    expect(recipe.reload.title).to eq('Grog')
    expect(page).to have_content('Grog')
  end

  scenario "updates the description of a recipe" do
    guybrush = create(:user, password: 'logMeIn')
    recipe = create(:recipe, user: guybrush)
    sign_in(guybrush, 'logMeIn')
    click_link('All recipes')
    click_link(recipe.title)
    expect do
      find('.sideBox.recipe textarea').set('Some love')
      find('body').click
      expect(find('.sideBox.recipe textarea').value).to eq('Some love')
    end.to change{recipe.reload.description}
  end

  scenario "changes the time" do
    guybrush = create(:user, password: 'logMeIn')
    recipe = create(:recipe, user: guybrush)
    sign_in(guybrush, 'logMeIn')
    click_link("All recipes")
    click_link(recipe.title)
    expect do
      within('.sideBox.recipe .recipe-options') do
        click_link("Time")
        expect(page).to have_content("15'")
      end
    end.to change{recipe.reload.time}
  end
end