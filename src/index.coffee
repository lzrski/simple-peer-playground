React         = require 'react'
{ render }    = require 'react-dom'
Peer          = require 'simple-peer'

p1 = Peer trickle: no, initiator: yes
p2 = Peer trickle: no

peer = null
connect = (signal) ->
  console.log 'Connecting to ', signal

  peer ?= Peer trickle: no, initiator: not signal

  if signal then peer.signal JSON.parse signal

  peer.on 'signal', (signal)  -> update {signal}
  peer.on 'connect', ()       -> update connected: yes
  peer.on 'data',   (data)    -> update {data}
  peer.on 'error',  (error)   -> console.error error

input = null
Connect = ({signal}) ->
  <div>
    <h1>Connect</h1>
    { if signal?
      <p>Your signal is:</p>
      <pre>{ JSON.stringify signal, null, 2}</pre>
    }
    <textarea
      placeholder = 'enter peer signaling data here...'
      ref         = { (element) -> input = element }
      style       = { width: '100%' }
    />
    <button
      onClick     = { () -> connect input.value }
    >
      Connect
    </button>
  </div>

Chat = ({ message }) ->
  <div>
    <h1>Connected :)</h1>
    <pre>{ message }</pre>
    <textarea
      placeholder = 'enter signaling data here...'
      ref         = { (element) -> input = element }
      style       = { width: '100%' }
    />
    <button
      onClick     = { () -> peer.send input.value }
    >
      send
    </button>
  </div>

App = ({ signal, connected, data }) ->
  if connected or data?
    <Chat message = { data?.toString 'utf-8' }/>
  else
    <Connect signal = { signal } />

container = document.getElementById 'app-container'
update = (props = {}) ->
  render (React.createElement App, props), container

do update
