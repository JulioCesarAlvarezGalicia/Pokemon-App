import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

/// Widget que muestra la información de un solo Pokémon.
class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(pokemon.imageUrl),
      title: Text(pokemon.name),
      subtitle: Text('Type: ${pokemon.types.join(', ')}'),
    );
  }
}
