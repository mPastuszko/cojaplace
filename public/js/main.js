$(function() {
  // Setup typeahead to display suggestions right away when focused
  var typeaheads = $("input[data-provide=typeahead]");
  typeaheads.on('focus',
    typeaheads.typeahead.bind(typeaheads, 'lookup'));
});

