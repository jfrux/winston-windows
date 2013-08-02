###!
* windows-test.js: Tests for instances of the Windows transport
*
* (C) 2013 Joshua F. Rountree
# * MIT LICENSE
*
###
path = require("path")
vows = require("vows")
assert = require("assert")
winston = require("winston")
helpers = require("winston/test/helpers")
Transport = require("../lib/winston-windows").Transport
transport = new Transport()

assertInstall = (transport) ->
  
assertWindows = (transport) ->
  assert.instanceOf transport, Transport
  assert.isFunction transport.log

assertLogs = () ->
  transport = new winston.transports.Windows()
  logger = new winston.Logger(transports: [transport])
  logger.log "info", "This is an INFORMATION test."
  logger.log "warn", "This is an WARNING test."
  logger.log "error", "This is an ERROR test."
vows
  .describe("winston-windows")
  .addBatch("An instance of the Windows Transport":
    "should have the proper methods defined": ->
      assertWindows transport

    "should log messages to Windows EventLog": ->
      assertLogs()
  )
.export module