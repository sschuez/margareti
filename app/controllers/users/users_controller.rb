class Users::UsersController < ApplicationController
  before_action :set_user, only: [:show]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user

    show_meta_tags(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def show_meta_tags(user)
    set_meta_tags title: user.name,
                  description: user.bio.presence || "To showcase your work and your ideas",
                  keywords: user.items.map(&:name).join(", "),
                  og: {
                    title: user.name,
                    description: user.bio.presence || "To showcase your work and your ideas",
                    type: "website",
                    url: user_url(user),
                    image: user.photo.attached? ? url_for(user.photo) : nil
                  },
                  twitter: {
                    card: "summary",
                    site: "@yourportfolio",
                    title: user.name,
                    description: user.bio.presence || "To showcase your work and your ideas",
                    image: user.photo.attached? ? url_for(user.photo) : nil
                  }
  end
end
