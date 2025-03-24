// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_app/models/pokemon_model.dart';



class PokemonRepository {
  final Dio _dio = Dio();
  int offset = 0;
  final int limit = 20;

  Future<List<Pokemon>> fetchPokemonList() async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon',
          queryParameters: {'limit': limit, 'offset': offset});

      final List results = response.data['results'];

      List<Pokemon> detailedPokemons = [];

      for (var result in results) {
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
