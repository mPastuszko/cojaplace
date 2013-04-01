###!
  Copyright 2013 Mikolaj Pastuszko (mikolaj.pastuszko@gmail.com)
  Licensed under the Apache License v2.0
  http://www.apache.org/licenses/LICENSE-2.0
###

setupTypeaheads = ->
  $("input[data-provide='typeahead']").
    after('<i class="icon icon-chevron-down drop-down" />').
    click (event) ->
      $(this).typeahead("lookup").typeahead("show")
  $('i.icon.drop-down').on 'click', (event) ->
    typeahead = $(this).prevAll("input[data-provide='typeahead']")
    typeahead.trigger('focus').trigger('click')

highlightErrorFields = (field_name) ->
  $("input[name=\"" + field_name + "\"]").parent().addClass "error"

$ ->
  setupTypeaheads()
  highlightErrorFields(error_field)
