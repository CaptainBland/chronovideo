/*Copyright Jaron Shulver 2015*/
require! express
require! http
require! \./models.ls
bl = (require! './blandlib.ls')

swallow = bl.swallow
db <- models.connect
app = express()
  ..set('views', 'client')
  ..set('view engine', 'jade')
  ..use(express.static('static'))

  ..route \/
  .get (req, res, next)->
    console.log 'test test'
    res.render(\layout, {})

  ..route \/ajax
  .get (req, res, next)->
    #do something with csrf tokens here
    console.log req.query.name
    switch(req.query.name)
    | \registerPage => res.render \register, {}
    | \video => res.send JSON.stringify name:\video, video: \DVmuFAcS9k0
    next!

  ..route \/ajax
  .post (req, res, next)->
    console.log req.param(\name)
    switch(req.param(\name))
    | \register => bl.create(models.User, req.param(\data), res)
    next!
  ..listen 8000
