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

`get(slug)` returns group (`Browet::Group` instance).
- `slug` - slug of the group.

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
- `slug` - slug of the category.

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
- `slug` - slug of the product.

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

