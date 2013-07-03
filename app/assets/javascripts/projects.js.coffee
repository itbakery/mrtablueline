# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('input[name*="startat"]').datepicker
    dateFormat: 'yy-mm-dd'
  $('input[name*="endat"]').datepicker
    dateFormat: 'yy-mm-dd'
  $('.best_in_place').best_in_place()
