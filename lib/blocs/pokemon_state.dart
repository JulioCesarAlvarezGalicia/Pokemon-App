import '../models/pokemon_model.dart';

/// Estado base del Bloc de Pokémon.
abstract class PokemonState {}

/// Estado inicial: aún no se ha cargado nada.
class PokemonInitial extends PokemonState {}

/// Estado mientras se están cargando los datos.
class PokemonLoading extends PokemonState {}

/// Estado cuando los datos se cargaron correctamente.
class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  PokemonLoaded(this.pokemons);
}

/// Estado cuando ocurrió un error.
class PokemonError extends PokemonState {
  final String message;
  PokemonError(this.message);
}
