###!
  Copyright 2013 Mikolaj Pastuszko (mikolaj.pastuszko@gmail.com)
  Licensed under the Apache License v2.0
  http://www.apache.org/licenses/LICENSE-2.0
###

removeDishHandler = (event) ->
  dishes = $(this).parents(".dishes")
  $(this).parent(".dish").remove()
  updateTotalPrice.call(dishes.get(0), event)

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
  order_form = $(this).parents('.order')
  dishes = Object.keys(Storage.dishes_with_prices[restaurant] || {})
  dish_fields = order_form.find(".dish input[name='dish[]']")
  if dish_fields.data('typeahead')
    dish_fields.data('typeahead').source = dishes
  else
    dish_fields.attr('data-source', JSON.stringify(dishes))

lookupPriceForDish = (event) ->
  restaurant = $('.restaurant input').val()
  dish = $(this).val()
  price_field = $(this).nextAll('input[name="price[]"]')
  price = Storage.dishes_with_prices[restaurant]?[dish]
  if price?
    price_field.val(price.toFixed(2))
    price_field.trigger('change')

updateTotalPrice = (event) ->
  dishes = if $(this).hasClass('dishes')
             $(this)
           else
             $(this).parents('.dishes')
  prices = dishes.find(".dish input[name='price[]']")
  total_field = dishes.find(".total-price")
  total = 0.0
  prices.each ->
    total += parseFloat($(this).val()) || 0.0
  total_field.text(total.toFixed(2))

$ ->
  $("#today-order .dish a.remove").click(removeDishHandler)
  $("#today-order .dishes a.add").click(addDishHandler)
  $("#today-order .restaurant input").
    change(toggleFormEnabled).
    change(refreshDishSuggestions).
    keyup(toggleFormEnabled).
    trigger('change')
  $("#today-order .dish input[name='dish[]']").
    change(lookupPriceForDish).
    keyup(lookupPriceForDish)
  $("#today-order .dish input[name='price[]']").
    change(updateTotalPrice).
    keyup(updateTotalPrice).
    trigger('change')

  
