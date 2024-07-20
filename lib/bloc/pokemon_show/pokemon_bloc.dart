import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/pokemon_show_model.dart';
import '../../repositories/pokemon_show_repository.dart';
import 'pokemon_events.dart';
import 'pokemon_states.dart';

class PokemonShowBloc extends Bloc<PokemonShowEvent, PokemonShowState> {
  final PokemonShowRepository pokemonShowRepository;
  bool isFetching = false;
  List<PokemonShow> shows = [];

  PokemonShowBloc(this.pokemonShowRepository) : super(ShowsLoadingState()) {
    on<LoadShowsEvent>((event, emit) async {
      emit(ShowsLoadingState());
      try {
        shows = await pokemonShowRepository.getShows();
        emit(ShowsLoadedState(shows));
      } catch (e) {
        emit(ShowsErrorState(e.toString()));
      }
    });

    on<SearchShowsEvents>((event, emit) async {
      emit(ShowsLoadingState());
      try {
        if (event.searchText == null) {
          emit(ShowsLoadedState(shows));
          return;
        }
        final filteredShows = event.searchText!.isEmpty
            ? shows
            : shows
                .where((show) => show.show.name
                    .toLowerCase()
                    .contains(event.searchText!.toLowerCase()))
                .toList();
        emit(ShowsLoadedState(filteredShows));
      } catch (e) {
        emit(ShowsErrorState(e.toString()));
      }
    });

    on<LoadDetailShowEvent>((event, emit) async {
      emit(ShowsLoadingState());
      try {
        emit(ShowsLoadingState());
        final show = await pokemonShowRepository.getShowDetails(event.id);
        emit(ShowsDetailsState(show));
      } catch (e) {
        emit(ShowsErrorState(e.toString()));
      }
    });
  }
}
