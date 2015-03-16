require 'action_view'

module Browet
  module Widget
    include ActionView::Helpers::OutputSafetyHelper # for raw function

    extend self

    def product_search_autocomplete(select_callback, enter_callback, render_callback = nil, html_id = nil, html_attrs = {})
      html_id = html_id.nil? ? 'browet-widget-product-search-autocomplite' : html_id
      attrs = html_attrs.merge({id: html_id}).map{|k,v| "#{k}=\"#{v}\""}.join(' ')
      raw "<select #{attrs}>
        </select>
        <script type=\"text/javascript\">
          browetProductSearchAutocomplete(
            '#{html_id}', #{Config.product_search_autocomplete_length},
            '/browet/#{Config.product_search_autocomplete_url}',
            '#{Config.identity}',
            #{render_callback.nil? ? 'undefined' : render_callback}, 
            #{select_callback}, #{enter_callback});
        </script>"
    end

  end
end
