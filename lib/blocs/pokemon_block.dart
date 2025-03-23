import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/models/pokemon_model.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';
import '../repositories/pokemon_repository.dart';

/// Bloc que maneja los eventos y estados relacionados con Pokémon.
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;
  List<Pokemon> allPokemons = [];
  int offset = 0;

  PokemonBloc(this.repository) : super(PokemonInitial()) {
    on<FetchPokemonsEvent>((event, emit) async {
      // Emitir solo si no hay carga previa
      if (state is! PokemonLoading) {
        emit(PokemonLoading());

        try {
          final pokemons = await repository.fetchPokemons(offset: offset);
          offset += 20;
          allPokemons.addAll(pokemons);

          // Mantener todos los Pokémon anteriores + nuevos
          emit(PokemonLoaded(List.from(allPokemons)));
        } catch (e) {
          emit(PokemonError(e.toString()));
        }
      }
    });
  }
}
