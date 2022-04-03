part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitHome extends HomeEvent {}

class Filter extends HomeEvent {
  String searchedText;

  Filter(this.searchedText);
}

class Unfilter extends HomeEvent {}
