var RunExamples = (function() {
  var test_running_class = 'test-running',
      test_classes = test_running_class + ' test-undefined test-passed test-failed',
      socket_url,
      project_id,
      run_examples,
      working_message,
      reset_tests,
      ws;
  
  
  
  function init(options) {
    socket_url      = options.socket_url;
    project_id      = options.project_id;
    run_examples    = $('#run_examples');
    working_message = $('#examples_running_message');
    reset_tests     = $('#reset_tests');
    
    if(run_examples.length > 0) {
      connect(defaultOnConnectHandler);
      run_examples.click(runExamples);
      reset_tests && reset_tests.click(resetExamples);
    }
  }
  
  function defaultOnConnectHandler() {
    sendMessage('hello');
    run_examples.show();
  }
  
  
  
  function connect(onopen, onclosed) {
    ws           = new WebSocket(socket_url);
    ws.onmessage = function(e) { handleMessage(e.data); };
    ws.onclose   = function()  { App.debug('wd.closed'); onclosed && onclosed(); };
    ws.onopen    = function()  { App.debug('ws.opened'); onopen && onopen(); }
  }
  
  
  
  function handleMessage(raw_message) {
    var json = JSON.parse(raw_message),
        message = json.message,
        data = json.data || {};
    
    App.debug('received "' + message + '"' + (data.project_id ? (' for project ' + data.project_id) : ''));
    
    if(data.project_id == project_id) {
      switch(message) {
        case 'started':
          startedRunningTests();
          break;
          
        case 'finished':
          finishedRunningTests();
          break;
          
        case 'result':
          applyResult(data);
          break;
      }
    }
  }
  
  function startedRunningTests() {
    working_message && working_message.html('Running...')
  }
  
  function finishedRunningTests() {
    $('.scenario, .feature').removeClass(test_running_class);
    working_message && working_message.hide();
    run_examples    && run_examples.show();
    reset_tests     && reset_tests.show();
  }
  
  function applyResult(data) {
    App.debug(data);
    var scenario = findScenario(data.feature_file, data.index);
    setTestStatus(scenario, data.status);
    scenario.parents('.feature').each(applyResultToFeature);
  }
  
  
  
  function findScenario(feature_file, index) {
    return $('.feature[data-path="' + feature_file + '"] > .scenarios > .scenario[data-index="' + index + '"]');
  }
  
  
  
  function applyResultToFeature() {
    var feature = $(this),
        statuses = getStatusesOfScenarios(feature),
        status = 'passed';
    
    // If any scenario fails, the feature fails
    // If any scenario is undefined, the feature is undefined
    // If any scenario is waiting to be run, we can't be sure it's pased yet
    if(statuses.contains('failed')) {
      status = 'failed';
    } else if(statuses.contains('undefined')) {
      status = 'undefined';
    } else if(statuses.contains('running')) {
      return;
    }
    
    setTestStatus(feature, status);
  }
  
  function getStatusesOfScenarios(feature) {
    var scenarios = [];
    feature.find('.scenario').each(function() {
      var test_class = getTestClasses($(this));
      test_class[0] && scenarios.push(test_class[0].substring(5));
    });
    return scenarios;
  }
  
  function getTestClasses(element) {
    return getClasses(element).grep(/^test-/);
  }
  
  function getClasses(element) {
    return element.attr('class').split(/\s+/);
  }
  
  
  
  function setTestStatus(elements, status) {
    var css = 'test-' + status;
    return elements.removeClass(test_classes.replace(css, '')).addClass(css);
  }
  
  
  
  function runExamples(e) {
    e.preventDefault();
    e.stopPropagation();
    
    if(ws.readyState > 1) { 
      connect(sendExecuteMessage);
    } else {
      sendExecuteMessage();
    }
  }
  
  function sendExecuteMessage() {
    sendMessage('execute', {features: 'all'});
    setTestStatus($('.scenario, .feature'), 'running');
    run_examples    && run_examples.hide();
    reset_tests     && reset_tests.hide();
    working_message && working_message.html('Loading...').show();
  }
  
  function sendMessage(message, data) {
    App.debug('sending "' + message + '"');
    data = data || {};
    data.project_id = project_id;
    ws.send(JSON.stringify({message: message, data: data}));
  }
  
  
  
  function resetExamples(e) {
    e.preventDefault();
    e.stopPropagation();
    
    $('.scenario, .feature').removeClass(test_classes);
    reset_tests.hide();
  }
  
  
  
  return {
    init: init
  }
})();