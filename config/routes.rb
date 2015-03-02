Rails.application.routes.draw do
  mount Browet::Engine => "/browet"
end
Browet::Engine.routes.draw do
  get Browet::Config.product_search_url => 'widget#autocomplite_search_product', :defaults => { :format => 'json' }
end