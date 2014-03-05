require 'spec_helper'

describe CurrentUsersController do

  before :each do
    @user = create(:user)
    login_user
  end

  describe "GET #show" do
    it "returns a successful json response" do
      expect(response).to be_success
    end
  end

  describe "PUT #update" do
    it "updates the user title" do
      put(:update, current_user: {username: 'Le Chuck'})
      expect(@user.username).to eq('Le Chuck')
    end

    it "returns a successful response" do
      put(:update, current_user: {username: 'Le Chuck'})
      expect(response).to be_success
    end

    it "renders the show template" do
      put(:update, current_user: {username: 'Le Chuck'})
      expect(response).to render_template(:show)
    end
  end

  describe "DELETE #destroy" do
    it "delete the user" do
      expect{delete(:destroy)}.to change{User.count}.by(-1)
    end

    it "renders nothing" do
      delete(:destroy)
      expect(response.body).to eq(" ")
    end
  end

  describe "PUT #upload_avatar" do

    it "updates its avatar" do
      @user.should_receive(:update!).with(avatar: 'a')
      put(:upload_avatar, qqfile: 'a')
      expect(response).to redirect_to(current_user_path)
    end

    it "redirects the user to the current_user_path" do
      put(:upload_avatar, qqfile: 'a')
      expect(response).to redirect_to(current_user_path)
    end
  end

  describe "DELETE #remove_avatar" do
    it "removes the avatar from the user" do
      user = create(:user_with_avatar)
      login_user(user)
      expect(user.has_avatar).to be_true
      delete(:remove_avatar)
      expect(user.has_avatar).to be_false
    end

    it "renders the show template" do
      delete(:remove_avatar)
      expect(response).to render_template(:show)
    end
  end
end