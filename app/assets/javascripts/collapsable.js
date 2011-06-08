// # class Collapsable
// #   constructor: (element) ->
// #     @element = $(element)
// #     @element.delegate 'li', 'click', () ->
// #       $(this).toggleClass 'collapsed'

var Collapsable;
Collapsable = (function() {
  function Collapsable(element) {
    this.element = $(element);
    this.element.addClass('tree')
    this.element.delegate('li > .caption', 'click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      return $(this).parent().toggleClass('collapsed');
    });
  }
  return Collapsable;
})();
