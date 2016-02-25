React         = require 'react'
{ render }    = require 'react-dom'
Peer          = require 'simple-peer'

p1 = Peer trickle: no, initiator: yes
p2 = Peer trickle: no

p1.on 'error', (error) -> console.error error

p1.on 'signal', (signal) -> p2.signal signal
p2.on 'signal', (signal) -> p1.signal signal

p2.on 'data', (data) -> console.log "Received", data.toString 'utf-8'

input = null

Chat = (props) ->
  <div>
    <textarea
      placeholder = 'enter signaling data here...'
      ref         = { (element) -> input = element }
      style       = { width: '100%' }
    />
    <button
      onClick     = { () -> p1.send input.value }
    >
      Connect
    </button>
  </div>

render (React.createElement Chat, {}), (document.getElementById 'app-container')
