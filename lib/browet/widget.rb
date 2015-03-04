module Browet
  module Widget
    extend self

    def product_search_autocomplete(selectCallback, enterCallback, css_class = 'browet-widget-autocomplite-search-product')
      # "<input class=\"#{css_class}\">
      # </input>
      # <option value=\"\" selected=\"selected\"></option>
      raw "<select class=\"#{css_class}\">
      </select>
      <script type=\"text/javascript\">
        var EMPTY_IDENTITY = 0;
        var selectize = jQuery('.#{css_class}').selectize({
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
            // selectize.close();
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
              selectize.clearOptions();
            }
          },
          onChange: function(slug_or_id) {
            if (slug_or_id != EMPTY_IDENTITY)
              #{selectCallback}(slug_or_id);
          },
          onEnterKeyPress: function(value) {
            #{enterCallback}(value);
          }
        })[0].selectize;
        var onKeyDown = selectize.onKeyDown.bind(selectize);
        selectize.onKeyDown = function(e) {
          var result = onKeyDown(e);
          if(e.keyCode == 13)  {
            //this.settings.onEnterKeyPress(this.items[0]);
            selectize.blur(); // to create entered nonexistant option
            if ( (this.items.length > 0) && (this.options[this.items[0]].#{Config.identity} == EMPTY_IDENTITY) )
              this.settings.onEnterKeyPress(this.options[this.items[0]].title);
          }
          return result;
        }.bind(selectize);
      </script>
      "
    end

  end
end
