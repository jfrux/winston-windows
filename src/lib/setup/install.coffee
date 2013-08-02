Service = require("node-windows").Service
config = require("../config")

# Create a new service object
svc = new Service(
  name: "WBX-WATCHDOG"
  description: "Watches for WBX billing files and handles transmission / encryption."
  script: require("path").join(process.cwd(), "app.js")
  env:
    name: "NODE_ENV"
    value: process.env.NODE_ENV
  env:
    name: "WATCHDOG_HOME"
    value: process.cwd()
)

# Listen for the "install" event, which indicates the
# process is available as a service.
svc.on "install", ->
  svc.start()


# Just in case this file is run twice.
svc.on "alreadyinstalled", ->
  console.log "This service is already installed."


# Listen for the "start" event and let us know when the
# process has actually started working.
svc.on "start", ->
  console.log svc.name + " started!"


# Install the script as a service.
svc.install()