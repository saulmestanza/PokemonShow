// To parse this JSON data, do
//
//     final pokemonShow = pokemonShowFromJson(jsonString);

import 'dart:convert';

import 'package:pokemon_show/models/image_show_model.dart';
import 'package:pokemon_show/models/rating_show_model.dart';
import 'package:intl/intl.dart';

List<PokemonShow> pokemonShowFromJson(String str) => List<PokemonShow>.from(
    json.decode(str).map((x) => PokemonShow.fromJson(x)));

String pokemonShowToJson(List<PokemonShow> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  Map<String, dynamic> toJson() => {
        "score": score,
        "show": show.toJson(),
      };
}

class Show {
  int id;
  String url;
  String name;
  String status;
  DateTime premiered;
  DateTime? ended;
  Rating rating;
  Image image;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.status,
    required this.premiered,
    required this.ended,
    required this.rating,
    required this.image,
  });

  String premieredToString() {
    return toDate(premiered);
  }

  String endedToString() {
    return toDate(ended);
  }

  String toDate(DateTime? now) {
    return now == null ? "" : DateFormat('MMM-yyy').format(now);
  }

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        status: json["status"],
        premiered: DateTime.parse(json["premiered"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        rating: Rating.fromJson(json["rating"]),
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "status": status,
        "premiered":
            "${premiered.year.toString().padLeft(4, '0')}-${premiered.month.toString().padLeft(2, '0')}-${premiered.day.toString().padLeft(2, '0')}",
        "ended":
            "${ended?.year.toString().padLeft(4, '0')}-${ended?.month.toString().padLeft(2, '0')}-${ended?.day.toString().padLeft(2, '0')}",
        "rating": rating.toJson(),
        "image": image.toJson(),
      };
}
