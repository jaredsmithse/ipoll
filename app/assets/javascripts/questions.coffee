$(document).ready -> 

  # teacher admin listeners
  $("#newQuestion").click addQuestion
  $("#newAnswer").click addAnswer
  $("body").on "click", "#newAnswer", addAnswer
  $("#questionForm").on "submit", submitQuestion
  $("body").on "submit", "#answerForm", submitAnswer

  # teacher present event listeners

  # question show event listeners
  $("#start").click startCollecting
  $("#stop").click stopCollecting
  

#############################
## Teacher Admin Functions ##
#############################

addQuestion = ->
  $('#questionForm').show()

addAnswer = (event) ->
  $button = $(event.target)
  $question = $button.closest('.question')
  $form = $question.find('#answerFormListItem')
  $form.show()


submitQuestion = (event) ->
  event.preventDefault()
  $.post @action, $(@).serialize()
  .done (response) ->
    $('#questionForm').hide()
    $("#questions").append(response)

submitAnswer = (event) ->
  event.preventDefault()
  $.post @action, $(@).serialize()
  .done (response) ->
    questionId = $(response).data("questionId")
    question = $("##{questionId}")
    question.find('#answers').append(response)
    $('#answerFormListItem').hide()

startCollecting = (event) ->
  event.preventDefault()
  url = "/questions/#{$('#questionShow').data('questionId')}/start"
  $("#stop .glyphicon").css("color", "white")
  $("#start .glyphicon").css("color", "green")
  $.get url

stopCollecting = (event) ->
  event.preventDefault()
  url = "/questions/#{$('#questionShow').data('questionId')}/stop"
  $("#start .glyphicon").css("color", "white")
  $("#stop .glyphicon").css("color", "red")
  $.get url


