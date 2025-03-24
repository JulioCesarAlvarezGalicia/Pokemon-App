import 'package:equatable/equatable.dart'; //Paquete que permite el uso de equatable para para evitar redibujar en caso de no cambiar el evento

abstract class PokemonEvent extends Equatable { //clase base para todos los eventos relacionados a los pokemon
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar la lista inicial de Pokémon
class FetchPokemon extends PokemonEvent {} //clase para cargar la lista con los  primeros pokemons al momento de abrir la app

/// Evento para cargar más Pokémon al hacer scroll
class FetchMorePokemon extends PokemonEvent {} //clase para cargar mas pokemons en lista ya existente en la app al hacer scroll
