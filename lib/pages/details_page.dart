import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_bloc.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_events.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_states.dart';
import 'package:pokemon_show/repositories/pokemon_show_repository.dart';

import '../models/details_show_model.dart';
import '../widgets/app_bar_widget.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonShowBloc(
        PokemonShowRepository(),
      )..add(LoadDetailShowEvent(
          id: widget.id,
        )),
      child: BlocConsumer<PokemonShowBloc, PokemonShowState>(
        listener: (context, state) {
          return;
        },
        builder: (context, state) {
          Show? show;
          if (state is ShowsInitialState || state is ShowsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShowsDetailsState) {
            show = state.show;
            context.read<PokemonShowBloc>().isFetching = false;
          }
          return Scaffold(
            backgroundColor: Colors.redAccent[100],
            body: SafeArea(
              child: Column(
                children: [
                  AppBarWidget(show),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Summary:",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            HtmlWidget(
                              show?.summary ?? "",
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Genres:",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Center(
                              child: Wrap(
                                spacing: 5.0,
                                children:
                                    (show?.genres ?? []).map((String genre) {
                                  return FilterChip(
                                    label: Text(genre),
                                    disabledColor: Colors.white,
                                    onSelected: null,
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Network:",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${show?.network?.name} - Runtime: ${show?.runtime} minutes.",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Aired:",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${show?.premieredToString()} - ${show?.endedToString()}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Text(
                                  "Rating:",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  " ${show?.rating.average}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Wrap(
                                spacing: 5.0,
                                children: [
                                  for (int i = 0;
                                      i < (show?.rating.average.toInt() ?? 0);
                                      i++)
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellowAccent,
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
