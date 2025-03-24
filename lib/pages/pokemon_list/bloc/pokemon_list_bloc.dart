import 'package:flutter_bloc/flutter_bloc.dart'; //Paquete que permite el uso del patron bloc
import 'package:pokemon_app/models/pokemon_model.dart'; //paquete con la definicion de la estructura de como luce un pokemon
import 'package:pokemon_app/repositories/pokemon_repository.dart'; //paquete para el manejo de las peticiones a la api
import 'pokemon_list_event.dart'; //archivo que define los eventos de este bloc
import 'pokemon_list_state.dart'; //archivo que define los estados de este bloc 

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> { //funcion que crea el bloc manejando la logica para obtener la lista de pokemon
  final PokemonRepository repository;

  PokemonBloc(this.repository) : super(PokemonInitial()) { //constructor de la clase
    on<FetchPokemon>(_onFetchPokemon);
    on<FetchMorePokemon>(_onFetchMorePokemon);
  }

  Future<void> _onFetchPokemon(FetchPokemon event, Emitter<PokemonState> emit) async {
    emit(PokemonLoading([])); // funcion para cambiar el estado de carga con lista vacía
    try {
      final pokemons = await repository.fetchPokemonList(); //llamado a la pokemon api
      emit(PokemonLoaded(pokemons, pokemons.isEmpty)); // Muestra el estado de carga de la lista de pokemones
    } catch (e) {
      emit(PokemonError(e.toString())); // Muestra el resultado del estado de error si algo falla
    }
  }

  Future<void> _onFetchMorePokemon(FetchMorePokemon event, Emitter<PokemonState> emit) async {
    final currentState = state;
    if (currentState is PokemonLoaded && !currentState.hasReachedEnd) {
      emit(PokemonLoading(currentState.pokemons)); // Carga máspokemones en la lista, conservando la lista actual
      try {
        final newPokemons = await repository.fetchPokemonList(); // Muestra nuevos Pokemones
        final allPokemons = List<Pokemon>.from(currentState.pokemons)..addAll(newPokemons); // Combina la lista actual con los nuevos pokemon
        emit(PokemonLoaded(allPokemons, newPokemons.isEmpty)); // Nuevo estado cargado
      } catch (e) {
        emit(PokemonError(e.toString())); // Muestra el resultado del estado de error si falla fetch
      }
    }
  }
}
