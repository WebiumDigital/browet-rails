# browet-rails

## Installation
1. Add `gem 'browet', :git => 'https://github.com/WebiumDigital/browet.git'` to Gemfile.
2. Run `bundle install`.
3. Run `rails generate browet:install`.
4. Run rake `rake db:migrate`
5. Modify Browet API **account** and **key** in config/initialize/browet.rb.

## Widgets Usage
To use widgets:
1. Add `//= require browet` to app/assets/javascript/application.js
2. Add ` *= require browet` to app/assets/stylesheets/application.css  
3. Use `Browet::Widget.widget_name(*args)` in views (OR add `include Browet::Widget` `widget_name(*args)` in views)
