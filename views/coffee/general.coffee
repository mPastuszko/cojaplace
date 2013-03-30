###!
  Copyright 2013 Mikolaj Pastuszko (mikolaj.pastuszko@gmail.com)
  Licensed under the Apache License v2.0
  http://www.apache.org/licenses/LICENSE-2.0
###

setupTypeaheads = (typeaheads) ->
  typeaheads.on "click", (event) ->
    $(event.target).typeahead("lookup").typeahead "show"

highlightErrorFields = (field_name) ->
  $("input[name=\"" + field_name + "\"]").parent().addClass "error"

$ ->
  setupTypeaheads $("input[data-provide=typeahead]")
  highlightErrorFields error_field
