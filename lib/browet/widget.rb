module Browet
  module Widget
    extend self

    def autocomplite_search_product(css_class = 'browet-widget-autocomplite-search-product')
      # "<input class=\"#{css_class}\">
      # </input>
      "<select class=\"#{css_class}\">
      <option value=\"\" selected=\"selected\"></option>
      </select>
      <script type=\"text/javascript\">
        var element = jQuery('.#{css_class}');
        element.selectize({
          createOnBlur: true,
          create: true,
          valueField: '#{Config.identity}',
          labelField: 'title',
          searchField: ['title', 'mpn'],
          render: {
            option: function(item, escape) {
              console.log('render: ' + item);
              return '<div class=\"item\"><div class=\"title\">' + escape(item.title) + 
                '</div><div class=\"mpn\">' + escape(item.mpn) + '</div></div>';
            }
          },
          load: function(query, callback) {
            console.log('load: ' + query);
            element[0].selectize.close();
            // if (!query.length) return callback();
            if (query.length >= #{Config.product_search_autocomplite_length})
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
          onLoad: function(data) {
            console.log('onLoad: ' + data);
            //element[0].selectize.open();
          },
          onType: function(str) {
            console.log('onType: ' + str);
          },
          onChange: function(value) {
            console.log('onChange: ' + value);
          }
        });
      </script>
      "
    end

  end
end
