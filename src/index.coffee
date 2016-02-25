React         = require 'react'
{ render }    = require 'react-dom'

container = document.getElementById 'app-container'

signal = null

Chat = (props) ->
  <div>
    <textarea
      placeholder = 'enter signaling data here...'
      ref         = { (element) -> signal = element }
      style       = { width: '100%' }
    />
    <button
      onClick     = { () -> console.log signal.value }
    >
      Connect
    </button>
  </div>

render (React.createElement Chat, {}), container
