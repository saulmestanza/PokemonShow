import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/details_show_model.dart';
import '../models/pokemon_show_model.dart';

class PokemonShowRepository {
  late http.Client client;

  PokemonShowRepository() {
    client = http.Client();
  }

  Future<List<PokemonShow>> getShows() async {
    List<PokemonShow> resp = [];
    try {
      String url = "https://api.tvmaze.com/search/shows?q=pokemon";
      final respHttp = await client.get(
        Uri.parse(url),
      );
      if (respHttp.statusCode == 200) {
        var body = const Utf8Decoder().convert(respHttp.bodyBytes);
        resp = pokemonShowFromJson(body);
      }
    } catch (e) {
      print(e.toString());
    }
    return resp;
  }

  Future<Show?> getShowDetails(int id) async {
    Show? show;
    try {
      String url = "https://api.tvmaze.com/shows/$id";
      final respHttp = await client.get(
        Uri.parse(url),
      );
      if (respHttp.statusCode == 200) {
        var body = const Utf8Decoder().convert(respHttp.bodyBytes);
        show = showFromJson(body);
      }
    } catch (e) {
      print(e.toString());
    }
    return show;
  }
}
