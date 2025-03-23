import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/pokemon_block.dart';
import 'screens/pokemon_list_screen.dart';
import 'repositories/pokemon_repository.dart';
import 'blocs/pokemon_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PokemonRepository();

    return MaterialApp(
      title: 'PokeAPI con Dio + BLoC',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PokemonBloc(repository)..add(FetchPokemonsEvent()),
        child: const PokemonListScreen(),
      ),
    );
  }
}
