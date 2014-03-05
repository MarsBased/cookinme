require 'spec_helper'

describe "sign_up" do
  it "signs up the user by email" do
    visit("/sign_up")
    within(".login-inputs") do
      fill_in("Name", with: "guybrush")
      fill_in("Email", with: "guy@brush.com")
      fill_in("Password", with: "logMeIn")
    end
    expect{click_button("Create account")}
      .to change{User.count}.by(1)
    expect(current_url).to eq(angular_app_url)
  end
end