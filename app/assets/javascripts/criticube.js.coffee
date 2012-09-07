window.Criticube =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Criticube.Routers.References()
    Backbone.history.start()

$(document).ready ->
  Criticube.init()
