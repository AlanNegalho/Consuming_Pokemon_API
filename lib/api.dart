import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Pokemons {
  List<Dados>? dados;

  Pokemons({this.dados});

  Pokemons.fromJson(Map<String, dynamic> json) {
    if (json['dados'] != null) {
      dados = <Dados>[];
      json['dados'].forEach((v) {
        dados!.add(Dados.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dados != null) {
      data['dados'] = dados!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dados {
  int? id;
  String? name;
  String? img;
  String? num;
  String? type;
  String? height;
  String? weight;
  List<String>? weaknesses;

  Dados({
    this.id,
    this.name,
    this.img,
    this.num,
    this.type,
    this.height,
    this.weight,
    this.weaknesses,
  });

  Dados.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    num = json['num'];
    type = json['type'].toString();
    height = json['height'];
    weight = json['weight'];
    weaknesses = json['weaknesses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['num'] = num;
    data['name'] = name;
    data['img'] = img;
    data['num'] = num;
    data['type'] = type;
    data['height'] = height;
    data['weight'] = weight;
    data['weaknesses'] = weaknesses;

    return data;
  }
}

Future<List<Dados>> dados() async {
  final List<dynamic> result = await fetchUsers();
  //print(result);
  List<Dados> pokemons;
  pokemons = (result).map((pokemon) => Dados.fromJson(pokemon)).toList();
  return pokemons;
}

const String url =
    "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

Future<List<dynamic>> fetchUsers() async {
  var result = await http.get(Uri.parse(url));
  return jsonDecode(result.body)['pokemon'];
}
