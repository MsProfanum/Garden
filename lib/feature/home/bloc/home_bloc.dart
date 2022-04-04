// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:garden/database/datasource.dart';
import 'package:garden/database/plant/plant_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DataSource dataSource;
  int currentPaginationPageNo = 0;
  final int pageSize = 10;
  bool isLastPage = false;

  HomeBloc(this.dataSource) : super(HomeInitial()) {
    List<Plant> plantList = [];

    _maybeIncreaseCurrentPaginationPageNo() {
      if (!isLastPage) {
        currentPaginationPageNo++;
      }
    }

    on<InitHome>((event, emit) async {
      try {
        plantList = await dataSource.findPlants(
            pageSize: pageSize, offset: currentPaginationPageNo);
        isLastPage = plantList.length < pageSize;
        _maybeIncreaseCurrentPaginationPageNo();
        emit(HomeLoaded(plants: plantList, isLastPage: isLastPage));
      } catch (e) {
        log('Could not fetch data: $e');
        emit(Error());
      }
    });
    on<Paginate>((event, emit) async {
      try {
        List<Plant> plants = await dataSource.findPlants(
            pageSize: pageSize, offset: pageSize * currentPaginationPageNo);
        plantList.addAll(plants);
        isLastPage = plants.length < pageSize;
        _maybeIncreaseCurrentPaginationPageNo();
        emit(HomeLoaded(plants: plantList, isLastPage: isLastPage));
      } catch (e) {
        log('Could not paginate data: $e');
        emit(Error());
      }
    });
    on<Filter>((event, emit) async {
      List<Plant> filteredPlantList = plantList
          .where((e) => e.name.startsWith(event.searchedText))
          .toList();
      emit(HomeLoaded(plants: filteredPlantList, isLastPage: isLastPage));
    });
    on<Unfilter>((event, emit) async {
      emit(HomeLoaded(plants: plantList, isLastPage: isLastPage));
    });
  }
}
