###!
  Copyright 2013 Mikolaj Pastuszko (mikolaj.pastuszko@gmail.com)
  Licensed under the Apache License v2.0
  http://www.apache.org/licenses/LICENSE-2.0
###

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
