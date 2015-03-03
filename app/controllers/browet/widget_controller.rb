module Browet
  class WidgetController < ApplicationController
    def autocomplite_search_product
      # prevent Not Modified response
      headers['Last-Modified'] = Time.now.httpdate
      
      begin 
        products = Product::find(params[:query])
      rescue Exception => e 
        # compose structure to show error
        products = [{title: e.message, Config.identity => 0}]
      end
      render :json => products
    end
  end
end
