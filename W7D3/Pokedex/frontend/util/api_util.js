export const fetchPokemon = (id) => {
  return $.ajax({
    method: 'GET',
    url: `/api/pokemon/${id}`
  });
};

export const fetchAllPokemon = () => {
  return $.ajax({
    method: 'GET',
    url: `/api/pokemon/`
  });
};
