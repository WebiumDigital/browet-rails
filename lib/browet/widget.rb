module Browet
  module Widget
    extend self

    def autocomplete_search_product(js_callback, css_class = 'browet-widget-autocomplite-search-product')
      # "<input class=\"#{css_class}\">
      # </input>
      # <option value=\"\" selected=\"selected\"></option>
      "<select class=\"#{css_class}\">
      </select>
      <script type=\"text/javascript\">
        var element = jQuery('.#{css_class}');
        element.selectize({
          plugins: ['restore_on_backspace'],
          createOnBlur: true,
          create: function(input, callback) {
            callback({title:input, #{Config.identity}:0});
          },
          persist: false,
          allowEmptyOption: true,
          valueField: '#{Config.identity}',
          labelField: 'title',
          searchField: ['title', 'mpn'],
          render: {
            option: function(item, escape) {
              return ('id' in item) ? '<div class=\"item\"><div class=\"title\">' + escape(item.title) + 
                '</div><div class=\"mpn\">' + escape(item.mpn) + '</div></div>' : '';
            },
            option_create: function(item, escape) {
              return '';
            }
          },
          load: function(query, callback) {
            // console.log('load: ' + query);
            element[0].selectize.close();
            // if (!query.length) return callback();
            if (query.length >= #{Config.product_search_autocomplete_length})
              $.ajax({
                url: '/browet/#{Config.product_search_url}',
                type: 'GET',
                data: {
                    query: query,
                },
                error: function() {
                    callback();
                },
                success: function(res) {
                    callback(res);
                }
              });
            else {
              //for (var i = 0; i < element[0].selectize.items.length; i++)
              //  element[0].selectize.removeItem(value, true);
              //element[0].selectize.refreshItems();
              element[0].selectize.clearOptions();
            }
          },
          onChange: function(value) {
            if (value != 0)
              #{js_callback}(value);
          }
        });
      </script>
      "
    end

  end
end
