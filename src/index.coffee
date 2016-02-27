React         = require 'react'
{ render }    = require 'react-dom'
Peer          = require 'simple-peer'

state = null
reset = () -> state =
  messages  : []
  peer      : null
  connected : no
  signal    : null

do reset

initiate = () ->
  console.log 'Initiating'

  peer = Peer initiator: yes

  signal = []
  peer.on 'signal', (data)  ->
    console.log 'signal'
    console.log JSON.stringify data

    signal.push data

    update Object.assign state, { signal, peer }



connect = (signal) ->
  console.log 'Connecting'
  peer = state.peer or Peer initiator: no

  signals = JSON.parse signal
  peer.signal signal for signal in signals

  signal = []
  peer.on 'signal', (data)  ->
    console.log 'signal'
    console.log JSON.stringify data

    signal.push data

    update Object.assign state, { signal, peer }

  peer.on 'connect', ()       ->
    console.log 'connected'
    update Object.assign state, connected: yes

  peer.on 'data',   (data)    ->
    console.log 'received data'
    msg = "> #{data.toString 'utf-8'}"
    state.messages.push msg
    update state

  peer.on 'close', ()         ->
    console.log 'closed'
    do reset
    update state

  peer.on 'error',  (error)   ->
    console.error error

  Object.assign state, { peer }

send = (message) ->
  state.messages.push "< #{message}"
  state.peer.send message
  update state

input = null
Connect = ({signal}) ->
  <div>
    <h1>Connect</h1>
    {
      if signal?
        <p>Your signal is:</p>
        <pre>{ JSON.stringify signal, null, 2}</pre>
      else
        <button onClick = { initiate }>Initiate connection</button>
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

Chat = ({ messages }) ->
  <div>
    <h1>Connected :)</h1>
    { messages.map (message, index) ->
      <pre key = { index }>{ message.toString 'utf-8' }</pre>
    }
    <textarea
      placeholder = 'write something...'
      ref         = { (element) -> input = element }
      style       = { width: '100%' }
    />
    <button
      onClick     = { () ->
        send input.value
      }
    >
      send
    </button>
  </div>

App = ({ signal, connected, messages }) ->
  if connected
    <Chat messages = { messages }/>
  else
    <Connect signal = { signal } />

container = document.getElementById 'app-container'
update = (props = {}) ->
  render (React.createElement App, props), container

do update
