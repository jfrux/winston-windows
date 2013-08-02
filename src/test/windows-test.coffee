###!
* windows-test.js: Tests for instances of the Windows transport
*
* (C) 2013 Joshua F. Rountree
# * MIT LICENSE
*
###
assertWindows = (transport) ->
  assert.instanceOf transport, Transport
  assert.isFunction transport.log
closeTopic = ->
  transport = new winston.transports.Windows()
  logger = new winston.Logger(transports: [transport])
  logger.log "debug", "Test message to actually use socket"
  logger.remove name: "Windows"
  transport
path = require("path")
vows = require("vows")
assert = require("assert")
winston = require("winston")
helpers = require("winston/test/helpers")
Windows = require("../lib/winston-windows").Transport
transport = new Windows()
#This is > 0 because winston-Windows.js line 124
vows.describe("winston-windows").addBatch("An instance of the Windows Transport":
  "should have the proper methods defined": ->
    assertWindows transport

  "the log() method": helpers.testWindowsLevels(transport, "should log messages to Windows EventLog", (ign, err, ok) ->
    assert.isTrue not err
    assert.isTrue ok
    assert.equal transport.queue.length, 0
  )
).export module