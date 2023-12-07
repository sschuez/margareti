class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [ :home ]

  def home 
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      default_user = User.find_by(email: 'stephens@hey.com')

      redirect_to user_path(default_user) if default_user

      # If no default user and not signed in, render the standard home page
      # The standard home page will be rendered by default if no redirect occurs
    end
  end
end
