module LoginMacros
  def sign_in user, password
    visit(root_path)
    within(".login-inputs") do
      fill_in('Email', with: user.email)
      fill_in('Password', with: password)
      click_button('Sign in')
    end
  end
end