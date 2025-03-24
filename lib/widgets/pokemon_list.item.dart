import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon_model.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final types = pokemon.types.map((e) => e.type.name).join(', ');

    return ListTile(
      leading: Image.network(pokemon.sprites.frontDefault),
      title: Text(
        pokemon.name.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Type(s): $types'),
    );
  }
}
