part of 'character_bloc.dart';

sealed class CharacterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoadMore extends CharacterEvent {}

final class Refreshed extends CharacterEvent {}
