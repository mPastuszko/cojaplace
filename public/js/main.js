$(function() {
  // Setup typeahead to display suggestions right away when focused
  var typeaheads = $("input[data-provide=typeahead]");
  typeaheads.on('focus',
    typeaheads.typeahead.bind(typeaheads, 'lookup'));
    
  // Setup error fields highlighter
  highlightErrorFields(error_field);

  // Setu remove dish links
  $('.dish a.remove').click(removeDishHandler);
  $('.dishes a.add').click(addDishHandler);
});

function highlightErrorFields(field_name) {
  $('input[name="' + field_name + '"]').parent().addClass('error');
}

function removeDishHandler(event) {
  $(event.target).parent('.dish').remove();
}

function addDishHandler(event) {
  var dish = $('#dish-template').clone();
  dish.removeAttr("id");
  dish.removeClass("hidden");
  dish.find('a.remove').click(removeDishHandler);

  dish.insertBefore('.dishes a.add');
}