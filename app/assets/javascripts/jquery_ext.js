/* Extend jQuery with functions for PUT and DELETE requests. */
jQuery.extend({
  put: function(url, data, callback, type) {
    if(jQuery.isFunction(data)) {
      callback = data;
      data = {};
    }
    
    data = data || {};
    data['_method'] = 'put';
    return jQuery.post(url, data, callback, type);
  },
  destroy: function(url, data, callback, type) {
    if(jQuery.isFunction(data)) {
      callback = data;
      data = {};
    }
    
    data = data || {};
    data._method = 'delete';
    return jQuery.post(url, data, callback, type);
  }
});
