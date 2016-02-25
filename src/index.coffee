React         = require 'react'
{ render }    = require 'react-dom'

container = document.getElementById 'app-container'
Chat = (props) ->
  <div>
    Lets Chat!
  </div>

render (React.createElement Chat, {}), container
