#this creates an iframe with the youtube player in it.
#the api is terribad and defines a bunch of global vars
export createYTPlayer = (a) ->
  if $(a.container)
    width = a.w || 640
    height = a.h || 390
    autoplay = a.autoplay || 0

    url ="http://www.youtube.com/embed/#{a.id}?autoplay=#{autoplay}"
    frame = $ \<iframe></iframe>
      .attr 'id', 'ytplayer'
      .attr 'type', 'text/html'
      .attr 'width', width
      .attr 'height', height
      .attr 'src', url

    $(a.container).append frame

#shortcut for creating tags. wonder if I'll remember it
export $T = (tag) -> "<#{tag}><#{tag}/>"

export postj = (data) -> $.post(\ajax, data, \json)
export getj = (data) -> $.getJSON(\ajax, data)


export getPage = (page, myDone)->
  $.get \ajax name:page
  .done (data)->
    $ \#container
      .empty()
      .append(data)
    myDone?(data)

  .fail (data)->
    errorbox = $ \#container .append($T div)
