part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  List<Plant> plants;

  HomeLoaded(this.plants);

  @override
  List<Object?> get props => [plants];
}
