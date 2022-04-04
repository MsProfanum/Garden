part of 'update_plant_bloc.dart';

@immutable
abstract class UpdatePlantState extends Equatable {}

class UpdatePlantInitial extends UpdatePlantState {
  @override
  List<Object?> get props => [];
}

class UpdatePlantLoaded extends UpdatePlantState {
  List<PlantType> plantTypes;

  UpdatePlantLoaded(this.plantTypes);

  @override
  List<Object?> get props => [plantTypes];
}

class UpdatedPlant extends UpdatePlantState {
  @override
  List<Object?> get props => [];
}

class DeletedPlant extends UpdatePlantState {
  @override
  List<Object?> get props => [];
}
