orm = require("orm")
sha256 = require("crypto-js/sha256")
#I'm lazy so I gave them some silly names. I don't really know why they
#separated these into modules. I might mixin them Who knows?!11!!
sec = orm.enforce.security
ran = orm.enforce.ranges
v = orm.enforce
pat = orm.enforce.patterns

export connect = (f)->

  err, db <- orm.connect('mysql://chronouser@localhost/chronovideo?pool=true')
  if err then console.log(err) else console.log("connected")

  export User = db.define("user", {
      username: String
      email: String
      password: String
      password2: String

      },{
      validations:
        username:
          * v.notEmptyString('Required')
          * v.required('Required (this may be a system error)')
          * sec.username({length: 3}, 'Must be greater than 3 characters long')

        password:
          * sec.password('luns6', 'Must have 6 characters, upper/lower case and a special character')
          * v.notEmptyString('Required')
          * v.required('Required (this may be a system error)')

        password2:
          * v.sameAs('password', 'Must match password')

        email:
          * pat.email('Must be a valid email')
      },{
      hooks:
        beforeSave: (next)->
          this.password = SHA256 this.password
          this.password2 = ''
          next
  })

  youtubeRegex = /(?:(?:youtube.*v=)([^"]+)(?:&)|(?:youtu\.be\/)(.+))(?:\n*)/
  export Video = db.define("video", {
    url: String

    },{
    validations:
        url:
          * v.notEmptyString('Required')
          * pat.match(youtubeRegex)
          * v.required('Required (this may be a system error)')
    #mwah
    },{
    hooks:
        beforeSave: (next)->
          this.url = this.url.match(youtubeRegex)[0]
          next
  })

  export Answer = db.define("answer", {
    total: Number
    correct: Number
  })

  User.hasMany(\videos, Video)
  Video.hasMany(\videos, Answer)
  f(db)
