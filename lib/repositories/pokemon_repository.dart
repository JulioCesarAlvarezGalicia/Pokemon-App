import 'package:dio/dio.dart';
import '../models/pokemon_model.dart';

/// Clase que maneja las peticiones a la PokeAPI.
class PokemonRepository {
  final Dio _dio = Dio();

  /// Obtiene una lista de Pokémon detallados desde la API.
  Future<List<Pokemon>> fetchPokemons({int limit = 20, int offset = 0}) async {
    try {
      final response = await _dio.get(
        'https://pokeapi.co/api/v2/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      final results = response.data['results'] as List;

      // Peticiones paralelas a la API para obtener detalles de cada Pokémon.
      final detailResponses = await Future.wait(
        results.map((p) => _dio.get(p['url'])),
      );

      // Convertir cada respuesta a objeto Pokemon
      return detailResponses
          .map((res) => Pokemon.fromJson(res.data))
          .toList();
    } catch (e) {
      throw Exception('Error al cargar Pokémon: $e');
    }
  }
}
