// To parse this JSON data, do
//
//     final show = showFromJson(jsonString);

import 'package:intl/intl.dart';
import 'dart:convert';

Show showFromJson(String str) => Show.fromJson(json.decode(str));

class Show {
  int id;
  String url;
  String name;
  String status;
  DateTime premiered;
  DateTime? ended;
  Image image;
  String summary;
  Network? network;
  String? officialSite;
  int? runtime;
  List<String>? genres;
  Rating rating;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.status,
    required this.premiered,
    required this.ended,
    required this.image,
    required this.runtime,
    required this.officialSite,
    required this.network,
    required this.summary,
    required this.genres,
    required this.rating,
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
        image: Image.fromJson(json["image"]),
        genres: List<String>.from(json["genres"].map((x) => x)),
        runtime: json["runtime"] ?? 0,
        officialSite: json["officialSite"],
        rating: json["rating"] == null
            ? Rating.empty()
            : Rating.fromJson(json["rating"]),
        network: json["network"] == null
            ? Network.empty()
            : Network.fromJson(json["network"]),
        summary: json["summary"],
      );
}

class Image {
  final String medium;
  final String original;

  Image({
    required this.medium,
    required this.original,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        medium: json["medium"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "original": original,
      };
}

class Network {
  int id;
  String name;
  Country country;
  dynamic officialSite;

  Network({
    required this.id,
    required this.name,
    required this.country,
    required this.officialSite,
  });

  factory Network.empty() => Network(
        id: 0,
        name: "TBD",
        country: Country.empty(),
        officialSite: "",
      );

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"],
        name: json["name"] ?? "TBD",
        country: Country.fromJson(json["country"]),
        officialSite: json["officialSite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country.toJson(),
        "officialSite": officialSite,
      };
}

class Country {
  String name;
  String code;
  String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.empty() => Country(
        name: "",
        code: "",
        timezone: "",
      );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "timezone": timezone,
      };
}

class Rating {
  double average;

  Rating({
    required this.average,
  });

  factory Rating.empty() => Rating(
        average: 0,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json["average"] == null ? 0 : json["average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
      };
}
