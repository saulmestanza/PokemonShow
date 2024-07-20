import 'package:intl/intl.dart';

class Show {
  int id;
  String url;
  String name;
  String status;
  DateTime premiered;
  DateTime? ended;
  Image image;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.status,
    required this.premiered,
    required this.ended,
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
        "image": image.toJson(),
      };
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
