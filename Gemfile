source 'https://rubygems.org'

ruby '3.2.2'

gem 'rails', '~> 8.0.0'

# Drivers
gem 'pg', '~> 1.1'
gem 'redis', '>= 4.0.1'

# Deployment
gem 'puma', '>= 5.0'
gem 'thruster'

# Jobs
gem 'sidekiq'

# Front-end
gem 'bootsnap', require: false
gem 'dartsass-rails'
gem 'importmap-rails'
gem 'simple_form'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# Authentication / Authorization
gem 'devise'
gem 'pundit'

# Markdown
gem 'redcarpet', '~> 3.6'
gem 'rouge', '~> 4.1'

# Other
# gem "bcrypt", "~> 3.1.7"
gem 'acts_as_list'
gem 'cloudinary'
gem 'image_processing', '~> 1.2'
gem 'jbuilder'
gem 'meta-tags', '~> 2.19'
gem 'sitemap_generator', '~> 6.3'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  # gem "debug"#, "1.5"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'pundit-matchers'
end
