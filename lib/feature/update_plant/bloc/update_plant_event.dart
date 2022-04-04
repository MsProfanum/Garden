part of 'update_plant_bloc.dart';

@immutable
abstract class UpdatePlantEvent {}

class InitUpdatePlant extends UpdatePlantEvent {}

class UpdatePlant extends UpdatePlantEvent {
  int id;
  String name;
  String type;
  int plantingDate;

  UpdatePlant(this.id, this.name, this.type, this.plantingDate);
}

class DeletePlant extends UpdatePlantEvent {
  Plant plant;

  DeletePlant(this.plant);
}
