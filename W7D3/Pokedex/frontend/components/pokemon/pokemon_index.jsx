import React from 'react';
import Sound from 'react-sound';

class PokemonIndex extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      play: false,
      playIdx: null
    };
    this.playSound.bind(this);
    this.stopSound.bind(this);
  }

  componentDidMount () {
    this.props.requestAllPokemon();
  }

  playSound(idx) {
    return (e) => {
      e.stopPropagation();
      this.setState({play: true, playIdx: idx});
    };
  }

  stopSound(e) {
    e.stopPropagation();
    this.setState({play: false, playIdx: null});
  }

  render() {
    const { pokemon } = this.props;
    const pokemonLis = pokemon.map((pokemon,idx) => {
      return(
        <li onMouseEnter={this.playSound(idx)} onMouseLeave={this.stopSound.bind(this)} key={idx}>
          <Sound url="/assets/bleep.mp3" playStatus={(this.state.play && this.state.playIdx === idx) ? Sound.status.PLAYING : Sound.status.STOPPED}/>
          <span className="pokemon-id">{pokemon.id}</span>
          <div>
            <img className="pokeball" src="/assets/pokeball.png"/>
            <img src={pokemon.image_url}/>
          </div>
          <span>{pokemon.name}</span>
        </li>
      );
    });
    return (
      <>
        <ul className="pokedex">
          {pokemonLis}
        </ul>
        <div className="pokedex-border"></div>
      </>
    );
  }
}

export default PokemonIndex;
