import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_bloc.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_events.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_states.dart';
import 'package:pokemon_show/models/pokemon_show_model.dart';
import 'package:pokemon_show/repositories/pokemon_show_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PokemonShow> _shows = [];
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonShowBloc(
        PokemonShowRepository(),
      )..add(LoadShowsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<PokemonShowBloc, PokemonShowState>(
              listener: (context, state) {
                return;
              },
              builder: (context, state) {
                if (state is ShowsInitialState ||
                    state is ShowsLoadingState && _shows.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ShowsLoadedState) {
                  _shows = [];
                  _shows.addAll(state.shows);
                  BlocProvider.of<PokemonShowBloc>(context).isFetching = false;
                }
                return Column(
                  children: [
                    TextField(
                      onChanged: (text) {
                        BlocProvider.of<PokemonShowBloc>(context).add(
                          SearchShowsEvents(searchText: text),
                        );
                      },
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: "Buscar",
                        hintText: "Buscar",
                        suffixIcon: IconButton(
                          onPressed: () {
                            textController.clear();
                            BlocProvider.of<PokemonShowBloc>(context)
                                .add(const SearchShowsEvents());
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_shows.isEmpty) ...[
                      const Card(
                        child: ListTile(
                          leading: Icon(Icons.search_off),
                          title:
                              Text("No se encontro un show con ese parametro"),
                        ),
                      ),
                    ],
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final pokemonShow = _shows[index];
                          return Stack(
                            children: [
                              Hero(
                                tag: pokemonShow.show.id,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.13,
                                  height: 250.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        pokemonShow.show.image.medium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.13,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0E3311)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20.0,
                                bottom: 30.0,
                                child: InkWell(
                                  onTap: () {
                                    //
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Text(
                                          pokemonShow.show.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${pokemonShow.show.status}: ${pokemonShow.show.premieredToString()} - ${pokemonShow.show.endedToString()}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: _shows.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
