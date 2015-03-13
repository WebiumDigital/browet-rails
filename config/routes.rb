Rails.application.routes.draw do
  mount Browet::Engine => "/browet"
end
Browet::Engine.routes.draw do
  get Browet::Config.product_search_autocomplete_url => 'widget#product_search_autocomplete'
end