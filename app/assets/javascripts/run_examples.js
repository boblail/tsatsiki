var RunExamples = (function() {
  
  function init(options) {
    var socket_url  = options.socket_url,
        project_id  = options.project_id;
    
    
    var ws = new WebSocket(socket_url),
        loader = $('ajax_loader');
    
    function sendMessage(message, data) {
      App.debug('sending "' + message + '"');
      data = data || {};
      data.project_id = project_id;
      ws.send(JSON.stringify({message: message, data: data}));
    }
    
    function applyResult(data) {
      App.debug(data);
      var feature = $$('li[data-path="' + data.feature_file + '"]')[0];
      data.scenarios.__each(function(scenario) {
        var li = feature.down('li[data-line="' + scenario.line + '"]');
        li.className = 'scenario ' + scenario.status;
      });
    }
    
    ws.onmessage = function(e) { 
      var json = JSON.parse(e.data),
          message = json.message,
          data = json.data || {};
      
      App.debug('received "' + message + '"' + (data.project_id ? (' for project ' + data.project_id) : ''));
      
      if(data.project_id == project_id) {
        switch(message) {
          case 'started':
            break;
            
          case 'finished':
            loader && loader.hide();
            break;
            
          case 'result':
            applyResult(data);
            break;
        }
      }
    };
    ws.onclose = function() { App.debug('closed'); };
    ws.onopen = function() { App.debug('open'); $('#run_examples').show(); };
    
    function runExamples() {
      sendMessage('execute', {features: 'all'});
      loader && loader.show();
    }
    
    $('run_examples').click(function() {
      runExamples();
    });
  }
  
  return {
    init: init
  }
})();