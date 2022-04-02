part of 'add_plant_bloc.dart';

@immutable
abstract class AddPlantEvent {}

class InitAddPlant extends AddPlantEvent {}

class SavePlant extends AddPlantEvent {
  String name;
  String type;
  int plantingDate;

  SavePlant(this.name, this.type, this.plantingDate);
}
