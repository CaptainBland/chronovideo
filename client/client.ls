#depends on jquery

getVideo = !->
  getj name:\video
    .done (response)->
      player = createYTPlayer{
          id: response.video
          container: \#videocontainer
      }
    .fail ->
      alert "Could not get video URL!"

getQuestions = !->
  getj name:\questions
    .done (data)->
      renderQuestions data?
    .fail (error)->
      console.log(error)

init = ->
  data <-! getPage \registerPage, _

  e <-! $('#registration').submit
  e.preventDefault!
  e.stopPropagation!
  structure = name:\register, data: {}
  do
    element <-! $('#registration .field').each
    structure.data[$(this).attr \name] = $(this).val!
  console.log structure
  postj(structure)
  .done (err)->
    if err then alert (err)
    else alert("You have registereeered")
  .fail (err)->
    alert("fail!")
    console.log(err)


    #$.postj(questionnaire, 'json')
    #  .done ->
    #  .fail ->
    #  .always ->

$ init!
