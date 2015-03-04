module Browet
  module Widget
    include ActionView::Helpers::OutputSafetyHelper # for raw function

    extend self

    def product_search_autocomplete(select_callback, enter_callback, render_callback = nil, css_class = 'browet-widget-product-search-autocomplite')
      raw "<select class=\"#{css_class}\">
        </select>
        <script type=\"text/javascript\">
          browetProductSearchAutocomplete(
            '#{css_class}', #{Config.product_search_autocomplete_length},
            '/browet/#{Config.product_search_autocomplete_url}',
            '#{Config.identity}',
            #{render_callback.nil? ? 'undefined' : render_callback}, 
            #{select_callback}, #{enter_callback});
        </script>"
    end

  end
end
