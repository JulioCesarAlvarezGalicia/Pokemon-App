import 'package:dio/dio.dart'; //paquete que sirve para realizar las peticiones HTTP
import 'package:pokemon_app/models/pokemon_model.dart';//paquete con la definicion de la estructura de como luce un pokemon



class PokemonRepository { //clase encargada de comunicarse con la api
  final Dio _dio = Dio(); //creacion de la instancia dio para las peticiones
  int offset = 0;
  final int limit = 20;

  Future<List<Pokemon>> fetchPokemonList() async { //funcion para realizar peticion get a la PokeApi para obtener la lista de pokemons
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon',
          queryParameters: {'limit': limit, 'offset': offset});

      final List results = response.data['results'];

      List<Pokemon> detailedPokemons = []; //lista vacia de los pokemones

      for (var result in results) { //for encargado de para agregar pokemones a la lista 
        final detailResponse = await _dio.get(result['url']);
        final pokemon = Pokemon.fromJson(detailResponse.data);
        detailedPokemons.add(pokemon);
      }

      offset += limit;
      return detailedPokemons;
    } catch (e) {
      throw Exception('Error al cargar Pokémon: $e');
    }
  }
}
