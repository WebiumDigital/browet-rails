//= require selectize
function browetProductSearchAutocomplete(
  elemnetId, autocompleteLength, autocompleteUrl, identity,
  renderCallback, onChangeCallback, onEnterKeyPressCallback
  ) {
  
  renderCallback = (typeof(renderCallback) !== 'undefined') 
    ? renderCallback 
    : function (item, escape) {
      return '<div class=\"item\"><div class=\"title\">' + escape(item.title) + 
        '</div><div class=\"mpn\">' + escape(item.mpn) + '</div></div>'
    };

  var EMPTY_IDENTITY = 0;
  var selectize = jQuery('#' + elemnetId).selectize({
    plugins: ['restore_on_backspace'],
    createOnBlur: true,
    create: function(input, callback) {
      var item = new Object;
      item['title'] = input;
      item[identity] = 0;
      callback(item);
    },
    persist: false,
    allowEmptyOption: true,
    valueField: identity,
    labelField: 'title',
    searchField: ['title', 'mpn'],
    render: {
      option: function(item, escape) {
        // only real items (products) have id property
        return ('id' in item) ? renderCallback(item, escape) : '';
      },
      option_create: function(item, escape) {
        return '';
      }
    },
    load: function(query, callback) {
      if (query.length >= autocompleteLength)
        $.ajax({
          url: autocompleteUrl,
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
        selectize.clearOptions();
      }
    },
    onChange: (typeof(onChangeCallback) == 'function')
      ? function(idOrSlug) { if (idOrSlug != EMPTY_IDENTITY) onChangeCallback(idOrSlug); }
      : null,
    onEnterKeyPress: (typeof(onEnterKeyPressCallback) == 'function')
      ? onEnterKeyPressCallback
      : null
  })[0].selectize;
  
  var onKeyDown = selectize.onKeyDown.bind(selectize);
  selectize.onKeyDown = function(e) {
    var result = onKeyDown(e);
    if(e.keyCode == 13)  {
      selectize.blur(); // to create entered nonexistant option
      if ( (this.items.length > 0) 
        && (this.options[this.items[0]][identity] == EMPTY_IDENTITY) 
        && (this.settings.onEnterKeyPress !== null) )
        this.settings.onEnterKeyPress(this.options[this.items[0]].title);
    }
    return result;
  }.bind(selectize);
}
