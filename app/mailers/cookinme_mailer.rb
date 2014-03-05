class CookinmeMailer < MandrillMailer::TemplateMailer
  default from: "noreply@cookin.me"

  def reset_password_email(user, reset_link)
    merge_vars = { reset_link: reset_link }
    template_content = {username: user.username}

    mandrill_mail(
      to: user.email,
      template: "password-recovery",
      subject: "Password Recovery",
      template_content: template_content,
      vars: merge_vars
    )
  end

end
