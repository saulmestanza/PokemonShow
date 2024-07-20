import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_show/models/pokemon_show_model.dart';
import 'package:pokemon_show/repositories/pokemon_show_repository.dart';

import '../test_data/pokemon_repository_reponse_data.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockPokemonShowRepository extends Mock implements PokemonShowRepository {}

void main() {
  late MockPokemonShowRepository repository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = MockPokemonShowRepository();
    registerFallbackValue(Uri.parse(""));
  });

  group('PokemonShowRepository', () {
    test('getShows returns a list of PokemonShow', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(
          ReponseData.getAllShows,
          200,
        ),
      );
      when(() => repository.getShows()).thenAnswer(
        (_) async => pokemonShowFromJson(ReponseData.getAllShows),
      );
      final shows = await repository.getShows();
      expect(shows, isA<List<PokemonShow>>());
      expect(shows.length, 2);
      expect(shows.first.show.name, 'Pokémon Generations');
    });
  });
}
