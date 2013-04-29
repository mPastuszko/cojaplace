###!
  Copyright 2013 Mikolaj Pastuszko (mikolaj.pastuszko@gmail.com)
  Licensed under the Apache License v2.0
  http://www.apache.org/licenses/LICENSE-2.0
###

prepareDataForPaybackModal = (e) ->
  e.preventDefault()
  debt = $(this).parents('tr')
  debtor = debt.find('.debtor').text()
  amount = debt.find('.amount').text()
  modal = $('#paybackModal')
  modal.attr('data-payer', debtor)
  modal.attr('data-amount', amount)

preparePaybackModal = ->
  modal = $(this)
  payer = modal.attr('data-payer')
  amount = modal.attr('data-amount')
  modal.find('.payer').text(payer).val(payer)
  modal.find('.amount').val(amount)

$ ->
  $('.account .debtors .payback-action').on('click', prepareDataForPaybackModal)
  $('#paybackModal').on('show', preparePaybackModal)