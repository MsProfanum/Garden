import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garden/database/datasource.dart';
import 'package:garden/database/plant/plant_entity.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DataSource dataSource;
  HomeBloc(this.dataSource) : super(HomeInitial()) {
    List<Plant> plantList = [];
    on<InitHome>((event, emit) async {
      plantList = (await _getPlantList());
      emit(HomeLoaded(plantList));
    });
    on<Filter>((event, emit) async {
      List<Plant> filteredPlantList = plantList
          .where((e) => e.name.startsWith(event.searchedText))
          .toList();
      emit(HomeLoaded(filteredPlantList));
    });
    on<Unfilter>((event, emit) async {
      emit(HomeLoaded(plantList));
    });
  }

  Future<List<Plant>> _getPlantList() async => await dataSource.findAllPlants();
}
