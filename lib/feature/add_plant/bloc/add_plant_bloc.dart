// Dart imports:
import 'dart:math';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:garden/database/datasource.dart';
import 'package:garden/database/plant/plant_entity.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';

part 'add_plant_event.dart';
part 'add_plant_state.dart';

class AddPlantBloc extends Bloc<AddPlantEvent, AddPlantState> {
  final DataSource dataSource;
  AddPlantBloc(this.dataSource) : super(AddPlantInitial()) {
    on<InitAddPlant>((event, emit) async {
      List<PlantType> plantTypes = await dataSource.findAllPlantTypes();
      emit(AddPlantLoaded(plantTypes));
    });
    on<SavePlant>((event, emit) async {
      int plantId = event.name.hashCode +
          event.type.hashCode +
          event.plantingDate.hashCode;
      await dataSource.insertPlant(
          Plant(plantId, event.name, event.type, event.plantingDate));
      emit(PlantSaved());
    });
  }
}
