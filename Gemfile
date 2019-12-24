# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'bcrypt', '~> 3.1.7'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'mysql2', '0.5.2'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
end

gem 'bootstrap', '~> 4.1.1'
gem 'carrierwave'
gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'dotenv-rails'
gem 'fog-aws'
gem 'jquery-rails'
gem 'kaminari', '~> 0.17.0'
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'rails-i18n', '~> 5.1'
gem 'refile', github: 'refile/refile', require: 'refile/rails'
gem 'refile-mini_magick', github: 'refile/refile-mini_magick'
gem 'rmagick'
