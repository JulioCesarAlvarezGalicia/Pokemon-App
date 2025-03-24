import 'package:flutter/material.dart'; //paquete que llama a todos los widgets basicos de flutter 
import 'package:pokemon_app/models/pokemon_model.dart'; //paquete que importa la clase Pokemon para poder usar objetos de este tipo

class PokemonListItem extends StatelessWidget {  //widget personalizado que representa un solo Pokemon en lista, recibe un Pokemon
  final Pokemon pokemon; 

  const PokemonListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) { //metodo build que convierte la lista de tipo Pokemon en un solo texto semparado por comas
    final types = pokemon.types.map((e) => e.type.name).join(', ');

    return ListTile(  //en el returno de esta funcion es la informacion del pokemon (Imagen, Nombre y Tipo o Tipos)
      leading: Image.network(pokemon.sprites.frontDefault),
      title: Text(
        pokemon.name.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Type(s): $types'),
    );
  }
}
