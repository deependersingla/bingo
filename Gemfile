source 'https://rubygems.org'
#ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'devise'
gem 'foundation-rails', '5.0.3.1'
gem 'mongoid', :github=>"mongoid/mongoid"
gem 'sendgrid'
gem 'simple_form'
gem 'therubyracer', :platform=>:ruby
#gem 'thin'
gem 'newrelic_rpm'
#gem 'unicorn'
#gem 'capistrano'
#gem 'capistrano-ext'
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rbenv', github: "capistrano/rbenv"
#gem 'net-ssh', '~> 2.8.1', :git => "https://github.com/net-ssh/net-ssh"
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'hub', :require=>nil
  gem 'rails_layout'
  gem 'debugger'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'mongoid-rspec', '>= 1.10.0'
end

gem 'rails_12factor', group: :production
gem "actionpack-action_caching", github: "rails/actionpack-action_caching"
