require 'spec_helper'

describe "create a recipe", js: true do
  include Capybara::Angular::DSL

  it "creates the recipe" do
    visit("/sign_up")
    within(".login-inputs") do
      fill_in("Name", with: "guybrush")
      fill_in("Email", with: "guy@brush.com")
      fill_in("Password", with: "logMeIn")
    end
    click_button("Create account")
    click_link("All recipes")
    find('.navbar').click_link('Recipe')
    expect(Recipe.count).to eq(1)
  end
end