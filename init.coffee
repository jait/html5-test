# init.coffee
# vim: sts=2 sw=2 et:

root = exports ? this

log = (msg) ->
  console?.log msg
  
readyBound = false
isReady = false
readyCallback = undefined

domReady = ->
  # Make sure that the DOM is not already loaded
  if not isReady
      #log "domReady!"
      # be sure document.body is there
      if not document.body
        return setTimeout(domReady, 13)

      # clean up loading event
      if document.removeEventListener?
        document.removeEventListener("DOMContentLoaded", domReady, false)
      else
        window.removeEventListener("load", domReady, false)

      # Remember that the DOM is ready
      isReady = true

      # execute the defined callback
      #for ( var fn = 0; fn < readyList.length; fn++) {
      #  readyList[fn].call($, []);
      #}
      #readyList.length = 0;
      readyCallback?(window, [])

  return

bindReady = ->
  return if readyBound
  readyBound = true

  if document.readyState is "complete"
    return domReady()
  else
    if document.addEventListener?
      document.addEventListener("DOMContentLoaded", domReady, false)
    window.addEventListener("load", domReady, false)

  return

onReady = (fn) ->
  bindReady()
  if isReady
    fn?.call(window, [])
  else
    readyCallback = fn

root.onReady = onReady
