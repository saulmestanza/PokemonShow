import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_bloc.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_events.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_states.dart';
import 'package:pokemon_show/models/pokemon_show_model.dart';
import 'package:pokemon_show/repositories/pokemon_show_repository.dart';

import '../test_data/pokemon_repository_reponse_data.dart';

class MockPokemonShowRepository extends Mock implements PokemonShowRepository {}

void main() {
  final shows = pokemonShowFromJson(ReponseData.getAllShows);
  late MockPokemonShowRepository mockRepository;
  late PokemonShowBloc pokemonShowBloc;

  setUp(() {
    mockRepository = MockPokemonShowRepository();
    pokemonShowBloc = PokemonShowBloc(mockRepository);
    registerFallbackValue(shows);
    pokemonShowBloc.shows = shows;
  });

  group('PokemonShowBloc', () {
    blocTest<PokemonShowBloc, PokemonShowState>(
      'emits [ShowsLoadingState, ShowsLoadedState] when LoadShowsEvent is added',
      build: () {
        when(() => mockRepository.getShows()).thenAnswer((_) async => shows);
        return pokemonShowBloc;
      },
      act: (bloc) => bloc.add(LoadShowsEvent()),
      expect: () => [
        ShowsLoadingState(),
        ShowsLoadedState(shows),
      ],
    );

    blocTest<PokemonShowBloc, PokemonShowState>(
      'emits [ShowsLoadingState, ShowsLoadedState] when SearchShowsEvent is added with search text',
      build: () {
        return pokemonShowBloc;
      },
      act: (bloc) =>
          bloc.add(const SearchShowsEvents(searchText: "Generations")),
      expect: () => [
        ShowsLoadingState(),
        ShowsLoadedState([shows.first]),
      ],
    );

    blocTest<PokemonShowBloc, PokemonShowState>(
      'emits [ShowsLoadingState, ShowsLoadedState] when SearchShowsEvent is added with empty search text',
      build: () {
        return pokemonShowBloc;
      },
      act: (bloc) => bloc.add(const SearchShowsEvents(searchText: "")),
      expect: () => [
        ShowsLoadingState(),
        ShowsLoadedState(shows),
      ],
    );

    blocTest<PokemonShowBloc, PokemonShowState>(
      'emits [ShowsLoadingState, ShowsDetailsState] when LoadDetailShowEvent is added',
      build: () {
        when(() => mockRepository.getShowDetails(1))
            .thenAnswer((_) async => shows.first.show);
        return pokemonShowBloc;
      },
      act: (bloc) => bloc.add(const LoadDetailShowEvent(id: 1)),
      expect: () => [
        ShowsLoadingState(),
        ShowsDetailsState(shows.first.show),
      ],
    );

    blocTest<PokemonShowBloc, PokemonShowState>(
      'emits [ShowsLoadingState, ShowsErrorState] when LoadDetailShowEvent fails',
      build: () {
        when(() => mockRepository.getShowDetails(1))
            .thenThrow(Exception('Failed to load show details'));
        return pokemonShowBloc;
      },
      act: (bloc) => bloc.add(const LoadDetailShowEvent(id: 1)),
      expect: () => [
        ShowsLoadingState(),
        ShowsErrorState('Exception: Failed to load show details'),
      ],
    );
  });
}
