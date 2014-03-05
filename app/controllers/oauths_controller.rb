class OauthsController < ApplicationController
  skip_before_filter :require_login
  before_filter :check_errors, on: :callback

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to(root_path)
    else
      create_user(provider) # when its not in the platform
    end
  end

  private

    # Signs up a new user comming from an external application.
    # Recovers from errors and logs the user into de application if successful.
    def create_user provider_name
      begin
        attrs = user_attrs(@provider.user_info_mapping, @user_hash)
        @user = User.find_by(email: attrs[:email])
        @user ||= create_with_avatar_from(provider_name)
        reset_session
        auto_login(@user)
        add_provider_to_user(provider_name)
        redirect_to(root_path)
      rescue
        redirect_to(root_path,
          :error => "Failed to login from #{provider_name.titleize}!"
        )
      end
    end

    # This method only creates the user if the user email is not already in
    # the database.
    # That prevents a user signup with the same email using two different
    # providers. It also sets the avatar if comes from a facebook provider.
    def create_with_avatar_from provider_name
      create_from(provider_name) do |user|
        user_id = @user_hash[:user_info]["id"]
        if provider_name == "facebook"
          user.remote_avatar_url =
            "https://graph.facebook.com/#{user_id}/picture?width=120&height=120"
        elsif provider_name == "google"
          user.remote_avatar_url =
            "http://profiles.google.com/s2/photos/profile/#{user_id}?sz=120"
        end
        true
      end
    end

    def check_errors
      if params["error"] == "access_denied"
        redirect_to(
          sign_in_path,
          error: "Cookin.me cannot access your data on
            #{params["provider"].titleize}"
        )
        false
      end
      true
    end

    def auth_params
      params.permit(:code, :provider)
    end
end
