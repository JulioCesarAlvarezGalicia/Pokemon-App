import 'package:flutter/material.dart'; //Paquete que llama a todos los widgets basicos de flutter
import 'package:flutter_bloc/flutter_bloc.dart'; //Paquete que permite el uso del patron bloc
import 'package:pokemon_app/pages/pokemon_list/bloc/pokemon_list_bloc.dart'; //Paquete que importa el archivo pokemon_list_bloc.dart, el cual contiene la logica prinicipal para gestionar el estado de la lista Pokemon
import 'package:pokemon_app/pages/pokemon_list/bloc/pokemon_list_event.dart'; // Paquete que contiene las definicionesz de los eventos que el bloc puede manejar
import 'package:pokemon_app/pages/pokemon_list/bloc/pokemon_list_state.dart'; //paquete que define los estados de la aplicacion que el bloc puede emitier en respuesta a los eventos
import 'package:pokemon_app/repositories/pokemon_repository.dart'; //Paquete para el manejo de las peticiones a la api
import 'package:pokemon_app/widgets/pokemon_list.item.dart'; //Paquete que importa el widget que se usa para mostrar cada Pokemon en la lista

class PokemonListScreen extends StatelessWidget { //widget sun estado que actua como pantalla principal para mostrar la lista de Pokeemones
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider( //widget que provee el PokemonBloc a todos los widgets dentro de su arbol
      create: (context) => PokemonBloc(context.read<PokemonRepository>())..add(FetchPokemon()),
      child: const PokemonListView(), //widget que maneja la vista de la lista de pokemones estando dentro de BlocProvider
    );
  }
}

class PokemonListView extends StatefulWidget { //widget con estado que gestiona el estado del scroll para cargar mas Pokemones cuando estas al final de la lista
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() { //metodo para agregar un listener al scroll para detectar cuando el usuario esta cerca del final de la lista (a 200 pixeles)
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
    return Scaffold( //proporciona la estructura basica de la pantalla
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
      body: BlocBuilder<PokemonBloc, PokemonState>( //BlocBuilder escucha los cambios den el estado de PokemonBloc y reconstruye la UI en funcion al estado actual
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
