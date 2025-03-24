import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/pokemon_bloc.dart';
import 'package:pokemon_app/bloc/pokemon_event.dart';
import 'package:pokemon_app/bloc/pokemon_state.dart';
import 'package:pokemon_app/repositories/pokemon_repository.dart';
import 'package:pokemon_app/widgets/pokemon_list.item.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí inyectamos el Bloc de forma segura, asegurándonos de que el repositorio ya exista en el contexto
    return BlocProvider(
      create: (context) => PokemonBloc(context.read<PokemonRepository>())..add(FetchPokemon()),
      child: const PokemonListView(),
    );
  }
}

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // Verificamos si hemos llegado al final del scroll
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        final bloc = context.read<PokemonBloc>();
        if (bloc.state is PokemonLoaded && !(bloc.state as PokemonLoaded).hasReachedEnd) {
          bloc.add(FetchMorePokemon());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POKEMON LIST',
          style: TextStyle(
            fontFamily: 'PokemonSolid', // Fuente personalizada (debes tenerla en pubspec.yaml)
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading && state.previousPokemons.isEmpty) {
            // Primera carga
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonLoaded || (state is PokemonLoading && state.previousPokemons.isNotEmpty)) {
            // Carga más datos o ya está cargado
            final pokemons = state is PokemonLoaded ? state.pokemons : (state as PokemonLoading).previousPokemons;

            return ListView.builder(
              controller: _scrollController,
              itemCount: pokemons.length + 1, // +1 para indicador de carga al final
              itemBuilder: (context, index) {
                if (index < pokemons.length) {
                  return PokemonListItem(pokemon: pokemons[index]);
                } else {
                  // Mostrar indicador solo si aún hay más por cargar
                  final hasMore = state is PokemonLoaded ? !state.hasReachedEnd : true;
                  return hasMore
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }
              },
            );
          } else if (state is PokemonError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const SizedBox.shrink(); // Estado inicial
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
