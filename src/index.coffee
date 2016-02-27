React         = require 'react'
{ render }    = require 'react-dom'
Peer          = require 'simple-peer'

messages  = []
peer      = null

connect = (signal) ->
  console.log 'Connecting to ', signal

  unless peer?
    peer = Peer trickle: no, initiator: not signal

  if signal then peer.signal JSON.parse signal

  peer.on 'signal', (signal)  ->
    console.log 'signal'
    update {signal}

  peer.on 'connect', ()       ->
    console.log 'connected'
    update connected: yes

  peer.on 'data',   (data)    ->
    console.log 'received'
    messages.push "> #{data}"
    update { messages }

  peer.on 'close', ()         ->
    console.log 'closed'
    update {}

  peer.on 'error',  (error)   ->
    console.error error

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
    { messages.map (message, index) ->
      <pre key = { index }>{ message.toString 'utf-8' }</pre>
    }
    <textarea
      placeholder = 'enter signaling data here...'
      ref         = { (element) -> input = element }
      style       = { width: '100%' }
    />
    <button
      onClick     = { () ->
        console.log 'sending'

        peer.send input.value
      }
    >
      send
    </button>
  </div>

App = ({ signal, connected, messages }) ->
  if connected or messages?.length
    <Chat messages = { messages }/>
  else
    <Connect signal = { signal } />

container = document.getElementById 'app-container'
update = (props = {}) ->
  render (React.createElement App, props), container

do update
