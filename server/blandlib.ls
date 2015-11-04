export safe = (f, params, err) ->
  try
    f(params)
  catch
    console.log e
    if(err) then err(e)

export objMerge = (x, y) ->
  lstX = obj-to-pairs x
  lstY = obj-to-pairs y
  union (lstX lstY) |> pairs-to-obj

export create = (entity, data, res) ->
  err, items <-! entity.create(data, _)
  if err then res.send(err)

export maybe = (v) ->
  nothing =
    bind: (fn) -> this
    isNothing: -> true
    val: -> Error("cannot call val on nothing")
    maybe: (def, fn) -> def

  something =
    bind: (fn) ~> maybe(fn(this, value))
    isNothing: -> false
    val: -> v
    maybe: (def, fn)~> fn(this, value)
