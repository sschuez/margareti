class WorkerController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def refresh_sitemap
    system("rake -s sitemap:refresh")
    head :ok
    puts "🔥 Refreshed sitemap."
  end
end