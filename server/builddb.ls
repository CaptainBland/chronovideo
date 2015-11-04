require! \orm
require! \./models.ls

onconnect = ( db ) ->
  syncerr <-! db.sync
  console.log(syncerr)
  if syncerr then console.log(syncerr) else console.log('Done! :)')

models.connect(onconnect)
