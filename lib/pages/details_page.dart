import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_bloc.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_events.dart';
import 'package:pokemon_show/bloc/pokemon_show/pokemon_states.dart';
import 'package:pokemon_show/repositories/pokemon_show_repository.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
                return Column(
                  children: [
                    //
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
