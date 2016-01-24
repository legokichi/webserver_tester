express = require('express')
app = express()
server = require('http').Server(app)
io = require('socket.io')(server)
ExpressPeerServer = require('peer').ExpressPeerServer

app.use('/', express.static(__dirname + '/htdocs'))
app.use('/peerjs', ExpressPeerServer(server, {debug: true}))

io.on 'connection', (socket)->
  socket.on "echo", (data)-> socket.emit("echo", data)
  socket.on 'disconnect', console.info.bind(console, "socket:disconnect")

server.on "connection", console.info.bind(console, "peer:connection")
server.on "disconnect", console.info.bind(console, "peer:disconnect")

server.listen(8083)


