# 3dstarf.coffee
# vim: sts=2 sw=2 et:

root = exports ? this

canvas = undefined
ctx = undefined
starImageData = undefined

numStars = 200
stars = []
updateTimeout = undefined
updateInterval = 40 # ms
startTimeout = undefined
zMax = 256
zSpeed = updateInterval / 10 | 0
centerX = centerY = 0

log = (msg) ->
  console?.log msg

main = ->
  console?.log "main"
  # init
  canvas = document.getElementById("canvas")
  canvas.width = window.innerWidth
  canvas.height= window.innerHeight
  centerX = canvas.width / 2
  centerY = canvas.height / 2
  ctx = canvas.getContext("2d")

  ctx.fillStyle = "#000000"
  ctx.fillRect(0, 0, canvas.width, canvas.height)

  starImageData = ctx.createImageData(1, 1)
  starImageData.data[0] = 255
  starImageData.data[1] = 255
  starImageData.data[2] = 255
  starImageData.data[3] = 255 # opaque

  i = 0
  while i < numStars
    stars.push initStar()
    i++

  start()

  return

start = ->
  startTimeout = undefined
  updateTimeout = window.setInterval(update, updateInterval)

stop = ->
  clearTimeout updateTimeout if updateTimeout?

initStar = (star) ->
  star = star ? {}
  star.x = Math.random() * canvas.width * 2 - canvas.width | 0
  star.y = Math.random() * canvas.height * 2 - canvas.height | 0
  # avoid stars right in the middle
  if star.x is 0 and star.y is 0
    star.x = 1

  star.z = zMax
  star

drawStar = (x, y, intensity=255) ->
  starImageData.data[0] = intensity
  starImageData.data[1] = intensity
  starImageData.data[2] = intensity
  ctx.putImageData(starImageData, x, y)

update = ->
  ctx.fillRect(0, 0, canvas.width, canvas.height)
  intensityScale = 510 / zMax
  for s in stars
    #log s
    gx = s.x * 256 / s.z + centerX # center = the center of the screen
    gy = s.y * 256 / s.z + centerY
    #log("gx " + gx + " gy " + gy)
    if (gx < canvas.width) and (gx >- 1) and (gy < canvas.height) and (gy >- 1)
      # adjust intensity to make stars appear initially as dark
      #drawStar(gx, gy, 255 - (1.0 - (zMax - s.z) * 2 / zMax) * 255 | 0)
      drawStar(gx, gy, (zMax - s.z) * intensityScale | 0)
    else
      initStar s

    s.z = s.z - zSpeed
    if s.z is 0
      s.z = -1 # just to ensure...

  return

resize = ->
  stop()
  canvas.width = window.innerWidth
  canvas.height= window.innerHeight
  centerX = canvas.width / 2
  centerY = canvas.height / 2
  if startTimeout
    window.clearTimeout(startTimeout)
    startTimeout = undefined

  startTimeout = window.setTimeout(
    -> start()
    100)
  return

root.resize = resize
root.main = main
root.start = start
root.stop = stop
