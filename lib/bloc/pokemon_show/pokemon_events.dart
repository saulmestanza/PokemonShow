import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PokemonShowEvent extends Equatable {
  const PokemonShowEvent();
}

class LoadShowsEvent extends PokemonShowEvent {
  @override
  List<Object?> get props => [];
}

class SearchShowsEvents extends PokemonShowEvent {
  final String? searchText;

  const SearchShowsEvents({
    this.searchText,
  });

  @override
  List<Object?> get props => [];
}

class LoadDetailShowEvent extends PokemonShowEvent {
  final int id;

  const LoadDetailShowEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [];
}
