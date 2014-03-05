class UsersController < ExternalPagesController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user = login(@user.email, params[:user][:password], true)
      redirect_to(root_path)
    else
      render(:new)
    end
  end

  private

    def user_params
      params.require(:user).permit([:username, :email, :password])
    end
end