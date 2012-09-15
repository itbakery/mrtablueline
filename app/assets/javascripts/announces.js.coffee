# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
   $('#announce_publishon').datepicker({ dateFormat: 'yy-mm-dd'},{ numberOfMonths: 2 })
   $('#announce_publishoff').datepicker({ dateFormat: 'yy-mm-dd'},{ numberOfMonths: 2 })
