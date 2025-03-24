// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
    String name;
    Sprites sprites;
    List<TypeElement> types;

    Pokemon({
        required this.name,
        required this.sprites,
        required this.types,
    });

    factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        sprites: Sprites.fromJson(json["sprites"]),
        types: List<TypeElement>.from(json["types"].map((x) => TypeElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "sprites": sprites.toJson(),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
    };
}

class Sprites {
    String frontDefault;

    Sprites({
        required this.frontDefault,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
    };
}

class TypeElement {
    TypeType type;

    TypeElement({
        required this.type,
    });

    factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
        type: TypeType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type.toJson(),
    };
}

class TypeType {
    String name;

    TypeType({
        required this.name,
    });

    factory TypeType.fromJson(Map<String, dynamic> json) => TypeType(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
