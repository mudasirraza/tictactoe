import React, { useState, useEffect } from 'react'
import axios from 'axios'
import consumer from "../../channels/consumer"

class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = { 
      game: {
        markers: {}
      } 
    }
    this.create_subscription()
  }

  componentDidMount() {
    const token = this.props.match.params.token

    if (token == undefined){
      axios.get('/api/v1/games.json')
        .then( resp => {
          this.setState({game: resp.data})
        })
        .catch( resp => console.log(resp) )
    } else {
      axios.get("/api/v1/games/" + token + ".json")
        .then( resp => {
          this.setState({game: resp.data})
        })
        .catch( resp => console.log(resp) )
    }
  }

  create_subscription(){
    consumer.subscriptions.create("GamesChannel", {
      connected() {
      },

      disconnected() {
      },

      received(data) {
        this.updateGame(data['game'])
      },

      updateGame: this.updateGame
    });
  }

  display_marker(prop) {
    if (prop == this.state.game.user) {
      return 'X'
    } else if (prop == undefined) {
      return '-'
    } else {
      return 'O'
    }
  }

  updateGame = (game) => {
    this.setState({game: game})
  }

  updateMarker(prop) {
    if(this.state.game.markers[prop] !== undefined) {
      console.log('It has already been marked')
    } else {
      axios.post('/api/v1/games/mark.json', {
        marker: {
          index_num: prop
        }
      })
      .then( resp => console.log("got response" + resp))
      .catch( resp => console.log("got error" + resp))
    }
  }

  startNewGame() {
    axios.get('/api/v1/games/new.json')
      .then( resp => {
        this.setState({game: resp.data})
      })
      .catch( resp => console.log(resp) )
  }

  render () {
    return (
      <div className="center">
        <p> Invite the second player with the url: {"http://localhost:3000/api/v1/game/" + this.state.game.token} </p>
        <p> Click on any tile to make your move. </p>
        <div className="error"></div>
        <p> {this.state.game.winner && (this.state.game.winner == this.state.game.user ? 'Player 1 won!' : 'Player 2 is won!')} </p>

        <table className="center">
          <tbody>
            <tr>
              <td onClick={() => this.updateMarker(1)}>{ this.display_marker(this.state.game.markers[1]) }</td>
              <td onClick={() => this.updateMarker(2)}>{ this.display_marker(this.state.game.markers[2]) }</td>
              <td onClick={() => this.updateMarker(3)}>{ this.display_marker(this.state.game.markers[3]) }</td>
            </tr>
            <tr>
              <td onClick={() => this.updateMarker(4)}>{ this.display_marker(this.state.game.markers[4]) }</td>
              <td onClick={() => this.updateMarker(5)}>{ this.display_marker(this.state.game.markers[5]) }</td>
              <td onClick={() => this.updateMarker(6)}>{ this.display_marker(this.state.game.markers[6]) }</td>
            </tr>
            <tr>
              <td onClick={() => this.updateMarker(7)}>{ this.display_marker(this.state.game.markers[7]) }</td>
              <td onClick={() => this.updateMarker(8)}>{ this.display_marker(this.state.game.markers[8]) }</td>
              <td onClick={() => this.updateMarker(9)}>{ this.display_marker(this.state.game.markers[9]) }</td>
            </tr>
          </tbody>
        </table>

        <button onClick={() => this.startNewGame()}> Start new Game </button>
      </div>
    );
  }
}

export default Game
