import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/models/pokemon_model.dart';
import '../repositories/pokemon_repository.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;

  PokemonBloc(this.repository) : super(PokemonInitial()) {
    on<FetchPokemon>(_onFetchPokemon);
    on<FetchMorePokemon>(_onFetchMorePokemon);
  }

  Future<void> _onFetchPokemon(FetchPokemon event, Emitter<PokemonState> emit) async {
    emit(PokemonLoading([])); // Estado de carga con lista vacía
    try {
      final pokemons = await repository.fetchPokemonList(); // Fetch inicial
      emit(PokemonLoaded(pokemons, pokemons.isEmpty)); // Estado cargado
    } catch (e) {
      emit(PokemonError(e.toString())); // Error si algo falla
    }
  }

  Future<void> _onFetchMorePokemon(FetchMorePokemon event, Emitter<PokemonState> emit) async {
    final currentState = state;
    if (currentState is PokemonLoaded && !currentState.hasReachedEnd) {
      emit(PokemonLoading(currentState.pokemons)); // Carga más, conserva lista actual
      try {
        final newPokemons = await repository.fetchPokemonList(); // Fetch más Pokémon
        final allPokemons = List<Pokemon>.from(currentState.pokemons)..addAll(newPokemons); // Combina
        emit(PokemonLoaded(allPokemons, newPokemons.isEmpty)); // Nuevo estado cargado
      } catch (e) {
        emit(PokemonError(e.toString())); // Error si falla fetch
      }
    }
  }
}
