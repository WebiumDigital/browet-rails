# browet-rails

## Installation
1. Run `rails generate browet:install`.
2. Run rake `rake db:migrate`
3. Modify Browet API **account** and **key** in config/initialize/browet.rb.
4. To use widgets (`<%== Browet::Widget.autocomplite_search_product %>`):
  - add `gem "selectize-rails"` to Gemfile
  - add `//= require selectize` to app/assets/javascript/application.js
  - add ` *= require selectize` and ` *= require selectize.default` to app/assets/stylesheets/application.css  
