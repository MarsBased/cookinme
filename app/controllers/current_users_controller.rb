class CurrentUsersController < ApplicationController
  before_action :require_login
  respond_to :json

  # Returns the current_user
  def show
  end

  def update
    if current_user.update current_user_params
      render :show
    else
      render json: current_user.errors, status: 400
    end
  end

  # The param[:delete_confirmation] contains the password used
  # by the user to log_in
  def destroy
    current_user.destroy
    render nothing: true
  end

  def upload_avatar
    begin
      current_user.update!(avatar: params[:qqfile])
      redirect_to(current_user_path)
    rescue Exception => e
      logger.error e.message
      render nothing: true, status: 500
    end
  end

  def remove_avatar
    current_user.remove_avatar!
    current_user.save
    render :show
  end

  private

    def current_user_params
      params.require(:current_user).permit(:username, :email)
    end

end