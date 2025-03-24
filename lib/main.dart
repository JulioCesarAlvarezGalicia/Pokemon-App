import 'package:flutter/material.dart'; //Paquete que llama a todos los widgets basicos de flutter 
import 'package:flutter_bloc/flutter_bloc.dart'; //Paquete que permite el uso del patron bloc
import 'package:pokemon_app/repositories/pokemon_repository.dart'; //Paquete para el manejo de las peticiones a la api
import 'package:pokemon_app/pages/pokemon_list/pokemon_list_page.dart';  //Paquete que importa la pantalla en donde se muestra la lista de Pokemons

void main() { //funcion main que es entrada de la App en donde se inicia la aplicacion
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { //clase MyApp es el widget principal de la aplicacion
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider( //proporciona el PokemonRepository a toda la App
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
