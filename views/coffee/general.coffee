###!
  Copyright 2013 Mikolaj Pastuszko (mikolaj.pastuszko@gmail.com)
  Licensed under the Apache License v2.0
  http://www.apache.org/licenses/LICENSE-2.0
###

setupTypeaheads = ->
  typeaheads = $("input[data-provide='typeahead']")
  typeaheads.
    after('<i class="icon icon-chevron-down drop-down" />').
    click (event) ->
      # Save default matcher
      unless $(this).data('typeahead_matcher')
        $(this).data('typeahead_matcher', $(this).data('typeahead').matcher)
      # Set matcher that accept all items so that the suggestions list
      # shows everything when the field is clicked
      $(this).data('typeahead').matcher = -> true
      # Prepare and show suggestions list
      $(this).typeahead("lookup").typeahead("show")
      # Select all text within the field
      $(this).select()
    .keydown (event) ->
      # Restore fefault matcher if user starts using keyboard
      if $(this).data('typeahead_matcher')
        $(this).data('typeahead').matcher = $(this).data('typeahead_matcher')
  # Setup click event for drop-down icon
  $('i.icon.drop-down').click (event) ->
    typeahead = $(this).prevAll("input[data-provide='typeahead']")
    typeahead.trigger('focus').trigger('click')

highlightErrorFields = (field_name) ->
  $("input[name=\"" + field_name + "\"]").parent().addClass "error"

positionFooter = ->
  $('body').css('min-height', window.innerHeight - 30)

$ ->
  setupTypeaheads()
  highlightErrorFields(error_field)
  $(window).resize(positionFooter).resize()