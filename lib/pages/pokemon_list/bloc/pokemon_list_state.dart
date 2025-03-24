import 'package:equatable/equatable.dart';
import 'package:pokemon_app/models/pokemon_model.dart'; 

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial al abrir la app
class PokemonInitial extends PokemonState {}

/// Estado cuando se están cargando datos
class PokemonLoading extends PokemonState {
  final List<Pokemon> previousPokemons; // Guardamos la lista previa mientras carga más

  const PokemonLoading(this.previousPokemons);

  @override
  List<Object?> get props => [previousPokemons];
}

/// Estado cuando los datos se han cargado correctamente
class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons; // Lista de Pokémon actuales
  final bool hasReachedEnd;     // Indica si ya no hay más Pokémon por cargar

  const PokemonLoaded(this.pokemons, this.hasReachedEnd);

  @override
  List<Object?> get props => [pokemons, hasReachedEnd];
}

/// Estado cuando ocurre un error al cargar
class PokemonError extends PokemonState {
  final String message;

  const PokemonError(this.message);

  @override
  List<Object?> get props => [message];
}
