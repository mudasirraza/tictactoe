import React from "react"
import { BrowserRouter, Switch, Route } from 'react-router-dom'
import Game from './Game/Game'

class App extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={Game} />
          <Route exact path="/api/v1/game/:token" component={Game} />
        </Switch>
      </BrowserRouter>
    )
  }
}

export default App
