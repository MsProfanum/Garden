import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garden/database/datasource.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';
import 'package:meta/meta.dart';

part 'add_plant_event.dart';
part 'add_plant_state.dart';

class AddPlantBloc extends Bloc<AddPlantEvent, AddPlantState> {
  final DataSource dataSource;
  AddPlantBloc(this.dataSource) : super(AddPlantInitial()) {
    on<InitAddPlant>((event, emit) async {
      List<PlantType> plantTypes = await dataSource.findAllPlantTypes();
      emit(AddPlantLoaded(plantTypes));
    });
  }
}
