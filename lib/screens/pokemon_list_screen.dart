import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/pokemon_bloc.dart';
import 'package:pokemon_app/widgets/pokemon_list.item.dart';
import '../bloc/pokemon_event.dart';
import '../bloc/pokemon_state.dart';

/// Pantalla que muestra la lista de Pokémon.
class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Detectar cuando llega al final de la lista
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          context.read<PokemonBloc>().state is! PokemonLoading) {
        context.read<PokemonBloc>().add(FetchPokemonsEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemon List',
          style: TextStyle(fontFamily: 'PokemonSolid'),
        ),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          final pokemons =
              (state is PokemonLoaded)
                  ? state.pokemons
                  : context.read<PokemonBloc>().allPokemons;

          return ListView.builder(
            controller: _scrollController,
            itemCount: pokemons.length + 1,
            itemBuilder: (context, index) {
              if (index < pokemons.length) {
                return PokemonListItem(pokemon: pokemons[index]);
              } else {
                // Mostrar cargando al final
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }
}
