module Features
  def sign_in
    sign_in_as("test@test.com", "Test User")
  end
  
  def sign_in_as(email, full_name)
    user = User.create!(
      email: email, 
      password: 'password', 
      full_name: full_name
    )
    login_as(user, scope: :user)
  end

  def sign_out
    logout(:user)
  end
end