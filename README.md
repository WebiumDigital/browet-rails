# Browet



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'browet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install browet

## Usage

Create an initializer (e.g. ./config/initializers/browet.rb) and specify config:

    Browet.options.browet_domain  = 'browet.local:3000'
    Browet.options.client_domain  = 'unloved'
    Browet.options.client_token   = '7eXtykEQONdl1zwUVAHdHQ'
    Browet.options.api_version    = '2'
    Browet.options.cache          = nil

Now you have access to standard high-level browet models

### Browet::CategoryGroup

Methods:

* all
* find(:id)
* find_by_slug(:slug)

Associations:

* categories
* products

### Browet::Category

Methods:

* find(:id)
* find_by_slug(:slug)

Associations:

* categories (children categories)
* parent (category)
* category_group
* products

### Browet::Product

Methods:

* all
* find(:id)
* find_by_slug(:slug)

Scopes for collection:

* search(:query)
* per(:per_page) (read about pagination below)
* page(:page_number) (read about pagination below)

Associations:

* brand
* categories
* pictures
* cover

Pagination:

You can use per and page method for collection, and even on associations like Browet::Category.find(3).products.page(2).
It returns you Kaminari::PaginatableArray object that can be easy handled with popular pagination gem - Kaminari.

## Caching

You can use [ActiveSupport::Cache::Store like object](http://guides.rubyonrails.org/caching_with_rails.html#cache-stores) for caching http request.
Pass a new object by setting it to options like

    Browet.options.cache = Memcached::Rails.new('127.0.0.1:11211')

or use configured cache of your rails application (we recommend you to use [memcached and dalii in this case](https://github.com/mperham/dalli))

    Browet.options.cache = Rails.cache

## Developing

This game was made on top of [her](https://github.com/remiprev/her) with few own hacks

## Contributing

1. Fork it ( https://github.com/[my-github-username]/browet/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
