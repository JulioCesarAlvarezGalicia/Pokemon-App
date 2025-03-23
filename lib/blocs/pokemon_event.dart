/// Evento base para manejar acciones relacionadas con Pokémon.
abstract class PokemonEvent {}

/// Evento que indica que se deben cargar más Pokémon.
class FetchPokemonsEvent extends PokemonEvent {}
