import {connect} from 'react-redux';
import PokemonIndex from './pokemon_index';
import {requestAllPokemon} from '../../actions/pokemon_actions';
import {selectAllPokemon} from '../../reducers/selectors';

const msp = (state) => {
  return {
    pokemon: selectAllPokemon(state),
  };
};

const mdp = (dispatch) => {
  return {
    requestAllPokemon: () => dispatch(requestAllPokemon()),
  };
};

export default connect(msp, mdp)(PokemonIndex);
