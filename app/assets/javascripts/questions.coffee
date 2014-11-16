$(document).ready -> 
  $("#newQuestion").click addQuestion
  $("#newAnswer").click addAnswer
  $("body").on "click", "#newAnswer", addAnswer
  $("#questionForm").on "submit", submitQuestion
  $("body").on "submit", "#answerForm", submitAnswer

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