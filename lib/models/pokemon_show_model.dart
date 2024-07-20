// To parse this JSON data, do
//
//     final pokemonShow = pokemonShowFromJson(jsonString);

import 'dart:convert';
import 'details_show_model.dart';

List<PokemonShow> pokemonShowFromJson(String str) => List<PokemonShow>.from(
    json.decode(str).map((x) => PokemonShow.fromJson(x)));

class PokemonShow {
  double score;
  Show show;

  PokemonShow({
    required this.score,
    required this.show,
  });

  factory PokemonShow.fromJson(Map<String, dynamic> json) => PokemonShow(
        score: json["score"]?.toDouble(),
        show: Show.fromJson(json["show"]),
      );
}
