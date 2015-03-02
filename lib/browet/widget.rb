module Browet
  module Widget
    extend self

    def autocomplite_search_product(css_class = 'browet-widget-autocomplite-search-product')
      "<select class=\"#{css_class}\">
      <option value=\"\" selected=\"selected\"></option>
      </select>
      <script type=\"text/javascript\">
        jQuery('.#{css_class}').selectize({
          valueField: '#{Config.identity}',
          labelField: 'title',
          searchField: 'title',
          options: [],
          render: {
            option: function(item, escape) {
              return '<div class=\"title\">' + escape(item.title) + '</div>';
            }
          },
          load: function(query, callback) {
            if (!query.length) return callback();
            $.ajax({
              url: '/browet/#{Config.product_search_url}',
              type: 'GET',
              data: {
                  search_query: query,
              },
              error: function() {
                  callback();
              },
              success: function(res) {
                  callback(res);
              }
            });
          }
        });
      </script>
      "
    end

  end
end
