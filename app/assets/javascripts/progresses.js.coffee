# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery -> $('#board').dataTable({
  "sDom": "<'row'<'span4'l><'span4'f>r>t<'row'<'span8'i><'span8'p>>",
  "sPaginationType": "bootstrap",
  "bInfo": false
})
