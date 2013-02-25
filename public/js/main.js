$(function() {
  // Setup typeahead to display suggestions right away when focused
  var typeaheads = $("input[data-provide=typeahead]");
  typeaheads.on('focus',
    typeaheads.typeahead.bind(typeaheads, 'lookup'));
    
  // Setup error fields highlighter
  highlightErrorFields(error_field);
});

function highlightErrorFields(field_name) {
  $('input[name="' + field_name + '"]').parent().addClass('error');
}
