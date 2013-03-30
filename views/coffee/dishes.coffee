removeDishHandler = (event) ->
  $(event.target).parent(".dish").remove()

addDishHandler = (event) ->
  dish = $("#dish-template").clone(true)
  dish.removeAttr "id"
  dish.removeClass "hidden"
  dish.insertBefore ".dishes a.add"

$ ->
  $(".dish a.remove").click removeDishHandler
  $(".dishes a.add").click addDishHandler
