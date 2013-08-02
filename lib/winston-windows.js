// Generated by CoffeeScript 1.6.3
var EventLogger, Transport, levels, util, winston,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

util = require("util");

winston = require("winston");

EventLogger = require("node-windows").EventLogger;

levels = Object.keys({
  info: 'Information',
  warn: 'Warning',
  error: 'Error'
});

Transport = (function(_super) {
  __extends(Transport, _super);

  function Transport(options) {
    Transport.__super__.constructor.call(this, options);
    this.name = options.name || "Winston-Windows";
    this.eventLogger = new EventLogger({
      source: this.name,
      eventLog: 'APPLICATION'
    });
  }

  Transport.prototype.log = function(level, msg, meta, callback) {
    var cloneMeta, data, logger, self;
    if (this.silent) {
      return callback(null, true);
    }
    if (!~levels.indexOf(level)) {
      return callback(new Error("Cannot log unknown EventLog level: " + level));
    }
    self = this;
    cloneMeta = winston.clone(meta);
    data = meta != null ? meta : {
      cloneMeta: {}
    };
    logger = this.eventLogger[level];
    logger(msg);
    return callback(null, true);
  };

  return Transport;

})(winston.Transport);

exports.Transport = Transport;

winston.transports.Windows = Windows;