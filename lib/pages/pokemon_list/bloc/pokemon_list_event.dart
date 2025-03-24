import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar la lista inicial de Pokémon
class FetchPokemon extends PokemonEvent {}

/// Evento para cargar más Pokémon al hacer scroll
class FetchMorePokemon extends PokemonEvent {}
