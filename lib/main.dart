import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/repositories/pokemon_repository.dart';
import 'package:pokemon_app/screens/pokemon_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => PokemonRepository(),  // Registra el repositorio
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        theme: ThemeData(
          fontFamily: 'PokemonFont',  // Fuente personalizada
          primarySwatch: Colors.red,
        ),
        home: const PokemonListScreen(),  // Pantalla principal
      ),
    );
  }
}
