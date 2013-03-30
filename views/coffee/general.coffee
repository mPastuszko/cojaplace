setupTypeaheads = (typeaheads) ->
  typeaheads.on "click", (event) ->
    $(event.target).typeahead("lookup").typeahead "show"

highlightErrorFields = (field_name) ->
  $("input[name=\"" + field_name + "\"]").parent().addClass "error"

$ ->
  setupTypeaheads $("input[data-provide=typeahead]")
  highlightErrorFields error_field
