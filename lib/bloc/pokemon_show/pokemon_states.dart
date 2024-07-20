import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_show/models/pokemon_show_model.dart';

@immutable
abstract class PokemonShowState extends Equatable {}

class ShowsInitialState extends PokemonShowState {
  @override
  List<Object?> get props => [];
}

//data loading state
class ShowsLoadingState extends PokemonShowState {
  @override
  List<Object?> get props => [];
}

class ShowsLoadedState extends PokemonShowState {
  final List<PokemonShow> shows;
  ShowsLoadedState(this.shows);
  @override
  List<Object?> get props => [shows];
}

class ShowsErrorState extends PokemonShowState {
  final String error;
  ShowsErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
