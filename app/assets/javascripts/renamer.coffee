class window.Renamer
  
  constructor: ->
    @selectedItem = null
  
  rename: (item)->
    
    # If we're starting a new rename,
    # cancel the current one
    @abortRename()
    
    @selectedItem = item
    if @selectedItem
      caption = @selectedItem.parent()
      input = $(document.createElement('input'))
      
      input.attr('type', 'text')
           .addClass('renamer')
           .blur(_.bind(@abortRename, @))
           .keyup(_.bind(@__onKeyUpInRename, @))
           .val(@selectedItem.first().text().replace(/^\s+/, ''))
           .prependTo(caption)
           .select()
      @selectedItem.addClass('being-renamed').hide()
  
  commitRename: ->
    if @selectedItem
      input = $('.renamer')
      name  = input.val()
      if name
        @selectedItem.html(name);
        @saveName(@selectedItem.attr('href'), name);
    @__endRename()
  
  abortRename: ->
    @__endRename()
  
  __endRename: ->
    $('.renamer').remove()
    $('.being-renamed').show()
    @selectedItem = null
  
  __onKeyUpInRename: (e)->
    if e.keyCode == 13 # Enter
      e.stopImmediatePropagation()
      @commitRename()
    if e.keyCode == 27 # Escape
      e.stopImmediatePropagation()
      @abortRename()
  
  saveName: (url, name)->
    $.put(url, {scenario: {name: name}})
