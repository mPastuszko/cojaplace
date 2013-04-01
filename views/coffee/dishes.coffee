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

toggleFormEnabled = (event) ->
  restaurant = $(this).val()
  restaurantIsEmpty = restaurant.length == 0
  $('#today-order .dishes input, #today-order .dishes select').prop('disabled', restaurantIsEmpty)
  $('#today-order .dishes a').toggleClass('hidden', restaurantIsEmpty)
  $('#today-order .dishes a + label').toggleClass('hidden', !restaurantIsEmpty)
  $('#today-order .payer select').prop('disabled', restaurantIsEmpty)
  $('#today-order .payer label').toggleClass('muted', restaurantIsEmpty)
  $('#today-order button.save').prop('disabled', restaurantIsEmpty)

refreshDishSuggestions = (event) ->
  restaurant = $(this).val()
  dishes = (Storage.dishes_with_prices[restaurant] || []).map (e) -> e.dish
  $('#today-order .dishes .dish input[name="dish[]"]').
    data('typeahead')?.source = dishes

$ ->
  $("#today-order .dish a.remove").click(removeDishHandler)
  $("#today-order .dishes a.add").click(addDishHandler)
  $("#today-order .restaurant input").
    change(toggleFormEnabled).
    change(refreshDishSuggestions).
    keyup(toggleFormEnabled).
    trigger('change')

  
