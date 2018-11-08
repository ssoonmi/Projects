import { RECEIVE_POKEMON, RECEIVE_ALL_POKEMON } from '../actions/pokemon_actions';
import { merge } from 'lodash';


const PokemonReducer = (state={}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_POKEMON:
      return state;
    case RECEIVE_ALL_POKEMON:
      const {pokemon} = action;
      return merge({}, state , pokemon);
    default:
      return state;
  }
};

export default PokemonReducer;
