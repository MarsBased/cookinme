require 'spec_helper'

describe "current_user_api" do

  it "redirects the user to the root path when the user is not logged in" do
    get "api/current_user", format: :json
    expect(response).to redirect_to(root_path)
  end

  context "when the user is logged in" do
    it "retrieves the current user information" do
      @user = create(:user_with_avatar, password: 'letMeIn')
      post("/sign_in", session: {email: @user.email, password: "letMeIn"})
      get "api/current_user", format: :json
      response_json = {
          id: @user.id,
          username: @user.username,
          email: @user.email,
          has_avatar: @user.has_avatar,
          avatar_url: @user.avatar_url,
          is_external: @user.external?
        }.to_json

      expect(response.body).to eq(response_json)
    end

    it "the default avatar is returned if the user has none" do
      @user = create(:user, password: 'letMeIn')
      post("/sign_in", session: {email: @user.email, password: "letMeIn"})
      get "api/current_user", format: :json
      expect(response.body).to include("/assets/default-avatar-small.png")
    end
  end
end