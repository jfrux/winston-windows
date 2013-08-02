util = require("util")
winston = require("winston")
EventLogger = require("node-windows").EventLogger
levels = Object.keys({
  info:'Information'
  warn:'Warning'
  error:'Error'
})
class Transport extends winston.Transport
  constructor: (options) ->
    super options
    @name = if options and options.name? then options.name else "Winston-Windows"
    @eventLogger = new EventLogger
      source: @name,
      eventLog: 'APPLICATION'
  log: (level,msg,meta,callback) ->
    return callback(null, true) if @silent
    return callback(new Error("Cannot log unknown EventLog level: #{level}")) if !~levels.indexOf(level)
    
    self = this
    cloneMeta = winston.clone(meta)
    data = meta ? cloneMeta : {}
    
    logger = @eventLogger[level]
    logger(msg)

    callback null, true


exports.Transport = Transport

winston.transports.Windows = Transport