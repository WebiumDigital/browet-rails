# browet-rails

## Installation
1. Add `gem 'browet', :git => 'https://github.com/WebiumDigital/browet.git'` to Gemfile.
2. Run `bundle install`.
3. Run `rails generate browet:install`.
4. Run rake `rake db:migrate`
5. Modify Browet API **account** and **key** in config/initialize/browet.rb.


## Main classes

### Browet::Group
#### Class methods
`list()` returns groups list (`Browet::ResultSet` instance).

`get(slug_or_id)` returns group (`Browet::Group` instance).
- `slug_or_id` - `slug` or `id` (depending on gem config) of the group.

#### Instance methods
`products(page = nil, limit = nil)` returns products list chunk of the group (`Browet::ResultSe`t instance). Returns full product list in case of `page` or `limit` is `nil`.
- `page` - chunk number to get, 
- `limit` - chunk size.

#### Instance attributes
- `id`
- `title`
- `name`
- `slug`
- `categories` (array of `Browet::Category` instances)

### Browet::Category
#### Class methods
`get(slug_or_id)` returns category (`Browet::Category` instance).
- `slug_or_id` - `slug` or `id` (depending on gem config) of the category.

#### Instance methods
`products(page = nil, limit = nil)` returns products list chunk of the category (`Browet::ResultSet` instance). Returns full product list in case of `page` or `limit` is `nil`.
- `page` - chunk number to get, 
- `limit` - chunk size.

#### Instance attributes
- `id`
- `title`
- `parent_id`
- `group_id`
- `slug`
- `subcategories` (array of `Browet::Category` instances)

### Browet::Product
#### Class methods
`list(page = nil, limit = nil)`  returns products list chunk (`Browet::ResultSet` instance). Returns full product list in case of `page` or `limit` is `nil`.
- `page` - chunk number to get, 
- `limit` - chunk size.

`get(slug_or_id)` returns product (`Browet::Products` instance).
- `slug_or_id` - `slug` or `id` (depending on gem config) of the product.

`find(search_query)`  returns products list (`Browet::ResultSe`t instance).
- `search_query` - query srting

#### Instance methods

#### Instance attributes
- `id`
- `description`
- `title`
- `guid`
- `mpn`
- `slug`
- `availability`
- `gtin`
- `currency`

### Browet::ResultSet
Chunked (paged) result set
#### Instance methods
- `each`
- `[]`
- `length`

#### Instance attributes
- `total_count` - total number of items
- `pages` - total number of chunks

## Widgets Usage
1. Add `//= require browet` to app/assets/javascript/application.js
2. Add ` *= require browet` to app/assets/stylesheets/application.css  
3. Use `Browet::Widget.widget_name(*args)` in views (OR add `include Browet::Widget` in app/helpers/application_helper.rb and use `widget_name(*args)` in views)

## Widgets
### product_search_autocomplete
Renders product search field with drop-down autocomplete based on [selectize.js](https://github.com/brianreavis/selectize.js)

`Browet::Widget::product_search_autocomplete(select_callback, enter_callback, render_callback, html_id, html_attrs)`
  - `select_callback` - (nil or string, _mandatory_) js-function name or js-closure which is fired when product is selected from drop-down list (for example: `function(slug_or_id) { console.log('selectCallback: ' + slug_or_id); }`)
  - `enter_callback` - (nil or string, _mandatory_) js-function name or js-closure which is fired when enter key is pressed within input field (for example: `function(string) { console.log('enterCallback: ' + string); }`)
  - `render_callback` - (nil or string, _optional_) js-function name or js-closure which is responsable for product rendering in drop-down list (default: `function(item, escape) { return '<div class=\"item\"><div class=\"title\">' + escape(item.title) + '</div><div class=\"mpn\">' + escape(item.mpn) + '</div></div>'; }`)
  - `html_id` - (string, _optional_) html id attribute of the widget select element (default: `browet-widget-product-search-autocomplite`)
  - `html_attrs` - (hash, _optional_) html attributes of the widget select element (default: `{}`)
