class SessionsController < ExternalPagesController

  def new
  end

  def create
    user = login(params[:session][:email], params[:session][:password], true)
    if user
      redirect_to(angular_app_path)
    else
      flash.now[:error] = "Invalid username or password."
      render(:new)
    end
  end

  # Sign out the current user
  def destroy
    logout
    render(nothing: true)
  end
end