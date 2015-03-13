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
3. Use `Browet::Widget.widget_name(*args)` in views (OR add `include Browet::Widget` in app/helpers/application_helper.rb and use `widget_name(*args)` in views)

## Widgets
### product_search_autocomplete
Renders product search field with drop-down autocomplete based on [selectize.js](https://github.com/brianreavis/selectize.js)

`product_search_autocomplete(select_callback, enter_callback, render_callback, css_class)`
  - `select_callback` - (nil or string, _mandatory_) js-function name or js-closure which is fired when product is selected from drop-down list (for example: `function(slug_or_id) { console.log('selectCallback: ' + slug_or_id); }`)
  - `enter_callback` - (nil or string, _mandatory_) js-function name or js-closure which is fired when enter key is pressed within input field (for example: `function(string) { console.log('enterCallback: ' + string); }`)
  - `render_callback` - (nil or string, _optional_) js-function name or js-closure which is responsable for product rendering in drop-down list (default: `function(item, escape) { return '<div class=\"item\"><div class=\"title\">' + escape(item.title) + '</div><div class=\"mpn\">' + escape(item.mpn) + '</div></div>'; }`)
  - `css_class` - (string, _optional_) css class which is applied to original select html element (default: `browet-widget-product-search-autocomplite`)