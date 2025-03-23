/// Modelo que representa la información detallada de un Pokémon.
class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
  });

  /// Crea una instancia de [Pokemon] a partir de un JSON.
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      types: (json['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
    );
  }
}
