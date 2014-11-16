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
  poller.init()
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


poller =
  
  # number of failed requests
  failed: 0
  
  # starting interval - 5 seconds
  interval: 500
  
  # kicks off the setTimeout
  init: ->
    # ensures 'this' is the poller obj inside getData, not the window object
    setTimeout $.proxy(@getData, this), @interval
    return

  
  # get AJAX data + respond to it
  getData: ->
    self = this
    $.ajax
      url: "/questions/#{$('#questionShow').data('questionId')}/tally"
      success: (response) ->
        $("#tally").html(response)
        # what you consider valid is totally up to you
        if response is "failure"
          self.errorHandler()
        else
          
          # recurse on success
          self.init()
        return

      
      # 'this' inside the handler won't be this poller object
      # unless we proxy it.  you could also set the 'context'
      # property of $.ajax.
      error: $.proxy(self.errorHandler, self)

    return

  
  # handle errors
  errorHandler: ->
    if ++@failed < 10
      
      # give the server some breathing room by
      # increasing the interval
      @interval += 1000
      
      # recurse
      @init()
    return


# # kick this thing off
# poller.init()


