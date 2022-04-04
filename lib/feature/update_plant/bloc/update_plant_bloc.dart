// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:garden/database/datasource.dart';
import 'package:garden/database/plant/plant_entity.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';

part 'update_plant_event.dart';
part 'update_plant_state.dart';

class UpdatePlantBloc extends Bloc<UpdatePlantEvent, UpdatePlantState> {
  final DataSource dataSource;
  UpdatePlantBloc(this.dataSource) : super(UpdatePlantInitial()) {
    on<InitUpdatePlant>((event, emit) async {
      List<PlantType> plantTypes = await dataSource.findAllPlantTypes();
      emit(UpdatePlantLoaded(plantTypes));
    });
    on<UpdatePlant>((event, emit) async {
      await dataSource.updatePlant(
          Plant(event.id, event.name, event.type, event.plantingDate));
      emit(UpdatedPlant());
    });
    on<DeletePlant>((event, emit) async {
      await dataSource.deletePlant(event.plant);
      emit(DeletedPlant());
    });
  }
}
