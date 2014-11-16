$(document).ready -> 
  $("#newQuestion").click addQuestion
  $("#questionForm").on "submit", submitQuestion

addQuestion = ->
  $('#questionForm').show()
  

submitQuestion = (event) ->
  event.preventDefault()
  $.post @action, $(@).serialize()
  .done (response) ->
    debugger