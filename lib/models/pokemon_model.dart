// To parse this JSON data, do
//
//     final pokemon = pokemonFromJson(jsonString);

import 'dart:convert';  //Paquete que importa herramientas para convertir datos en formato JSON a objetos dart

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str)); //funcion que convierte de formato JSON a un objeto de tipo Pokemon

String pokemonToJson(Pokemon data) => json.encode(data.toJson()); //funcion que convierte un objeto de tipo Pokemon a JSON

class Pokemon { //clase pokemon
    String name;
    Sprites sprites;
    List<TypeElement> types;

    Pokemon({ //constructor de la clase pokemon
        required this.name,
        required this.sprites,
        required this.types,
    });

    factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon( //funcion para convertir un mapa JSON a un objeto de tipo Pokemon
        name: json["name"],
        sprites: Sprites.fromJson(json["sprites"]),
        types: List<TypeElement>.from(json["types"].map((x) => TypeElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => { //funcion para convertir un objeto de tipo Pokemon a JSON
        "name": name,
        "sprites": sprites.toJson(),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
    };
}

class Sprites { //clase Sprites (imagenes)
    String frontDefault;

    Sprites({ //constructor de la clase Sprite
        required this.frontDefault,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) => Sprites( //funcion para convertir un mapa JSON a un objeto de tipo Sprite
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toJson() => { //funcion para convertir un objeto de tipo Sprite a JSON
        "front_default": frontDefault,
    };
}

class TypeElement { //clase TypeElement para el tipo de elemento del pokemon
    TypeType type;

    TypeElement({ //constructor de la clase TypeElement
        required this.type,
    });

    factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(//funcion para convertir un mapa JSON a un objeto de tipo TypeElement
        type: TypeType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => { //funcion para convertir un objeto de tipo TypeElement a JSON
        "type": type.toJson(),
    };
}

class TypeType { //clase TypeType para el tipo del pokemon
    String name;

    TypeType({ //constructor de la clase TypeType
        required this.name,
    });

    factory TypeType.fromJson(Map<String, dynamic> json) => TypeType(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
