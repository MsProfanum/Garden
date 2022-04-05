part of 'add_plant_bloc.dart';

@immutable
abstract class AddPlantState extends Equatable {}

class AddPlantInitial extends AddPlantState {
  @override
  List<Object?> get props => [];
}

class AddPlantLoaded extends AddPlantState {
  List<PlantType> plantTypes;

  AddPlantLoaded(this.plantTypes);

  @override
  List<Object?> get props => [plantTypes];
}

class PlantSaved extends AddPlantState {
  @override
  List<Object?> get props => [];
}
