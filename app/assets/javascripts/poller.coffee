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
    debugger
    $.ajax
      url: ""
      success: (response) ->
        
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