# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  Morris.Line
    element: 'tracks_chart'
    data: $('#tracks_chart').data('tracks')
    xkey: 'atmonth'
    ykeys: ['projection', 'actual']
    labels: ['Project Projection', 'Project Actual']
