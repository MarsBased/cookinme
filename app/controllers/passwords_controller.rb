class PasswordsController < ExternalPagesController

  def new
  end

  # As long as we are using Mandril, the emails are not being sent by Sorcery.
  def create
    @user = User.find_by_email(params[:password][:email])

    if @user
      @user.deliver_reset_password_instructions!
      send_recovery_email
      redirect_to(sign_in_path,
        notice: I18n.t("messages.password.create.success"))
    else
      flash.now[:error] = I18n.t("errors.password.invalid")
      render(:new)
    end
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    unless @user
      flash[:error] = I18n.t("errors.password.invalid_token")
      redirect_to(sign_in_path)
    end

  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])

    not_authenticated unless @user

    @user.password_confirmation = params[:user][:password_confirmation]
    @user.updates_password = true

    if @user.change_password!(params[:user][:password])
      redirect_to(sign_in_path,
        notice: I18n.t('messages.password.update.success'))
    else
      render :edit
    end
  end

  private

  def send_recovery_email
    CookinmeMailer.reset_password_email(
      @user,
      edit_password_url(@user.reset_password_token)
    ).deliver
  end

end
