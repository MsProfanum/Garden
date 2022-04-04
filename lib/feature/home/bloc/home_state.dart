part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  List<Plant> plants;
  bool isLastPage;

  HomeLoaded({required this.plants, required this.isLastPage});

  @override
  List<Object?> get props => [plants, isLastPage];
}

class Error extends HomeState {
  @override
  List<Object?> get props => [];
}
