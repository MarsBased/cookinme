# Constraint used by routes to determine if a user is LoggedIn or not.
# This way we can make our user to attack the Angular app if logged.
module LoggedInConstraint
  extend self

  def matches?(request)
    if request.session[:user_id]
      @current_user = User.try(:find, request.session[:user_id])
      @current_user.present?
    end
  rescue
    false
  end
end