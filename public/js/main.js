$(function() {
  setupTypeaheads($("input[data-provide=typeahead]"));

  // Setup error fields highlighter
  highlightErrorFields(error_field);

  // Setu remove dish links
  $('.dish a.remove').click(removeDishHandler);
  $('.dishes a.add').click(addDishHandler);
});

function setupTypeaheads(typeaheads) {
  // Display suggestions right away when clicked
  typeaheads.on('click', function(event) {
    $(event.target).typeahead('lookup').typeahead('show');
  });
}

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
  setupTypeaheads(dish.find('input[data-provide=typeahead]'));

  dish.insertBefore('.dishes a.add');
}