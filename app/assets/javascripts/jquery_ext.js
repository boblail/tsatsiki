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

jQuery.fn.extend({
  
  up: function(selector) {
    var previous = this.prev(selector),
        parent = this.parent(),
        previous_parent;
    
    // Look up the tree until we run out of parents
    while((previous.length == 0) && (parent.length > 0)) {
      
      // Does the parent's younger sibling have any descendents that match the selector?
      previous = parent.prev().find(selector).last();
      parent = parent.parent();
    }
    
    return previous;
  },
  
  down: function(selector) {
    var next = this.next(selector),
        parent = this.parent(),
        next_parent;
    
    // Look down the tree until we run out of parents
    while((next.length == 0) && (parent.length > 0)) {
      
      // Does the parent's older sibling have any descendents that match the selector?
      next = parent.next().find(selector).first();
      parent = parent.parent();
    }
    
    return next;
  }
  
});
