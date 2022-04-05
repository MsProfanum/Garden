// Project imports:
import 'package:garden/database/database.dart';
import 'package:garden/database/plant/plant_entity.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';

class DataSource {
  final AppDatabase database;

  DataSource(this.database);

  static Future<DataSource> newInstance() async {
    final dataSource = DataSource(
        await $FloorAppDatabase.databaseBuilder('garden_database.db').build());

    _maybeInsertPlantTypes(dataSource);

    return dataSource;
  }

  static void _maybeInsertPlantTypes(DataSource dataSource) async {
    if ((await dataSource.database.plantTypeDao.findAllPlantTypes()).isEmpty) {
      List<String> typesList = [
        'alpines',
        'aquatic',
        'bulbs',
        'succulents',
        'carnivorous',
        'climbers',
        'ferns',
        'grasses',
        'threes'
      ];
      for (String type in typesList) {
        await dataSource.database.plantTypeDao
            .insertPlantType(PlantType(typesList.indexOf(type), type));
      }
    }
  }

  Future<List<PlantType>> findAllPlantTypes() {
    return database.plantTypeDao.findAllPlantTypes();
  }

  Future<List<Plant>> findPlants({required int pageSize, required int offset}) {
    return database.plantDao.findAllPlants(pageSize, offset);
  }

  Future<Plant?> findPlantById(int id) {
    return database.plantDao.findPlantById(id);
  }

  Future<Plant?> findPlantByName(String name) {
    return database.plantDao.findPlantByName(name);
  }

  Future<List<Plant>?> findPlantByType(String type) {
    return database.plantDao.findPlantsByType(type);
  }

  Future<void> insertPlant(Plant plant) async {
    database.plantDao.insertPlant(plant);
  }

  Future<void> updatePlant(Plant plant) async {
    database.plantDao.updatePlant(plant);
  }

  Future<void> deletePlant(Plant plant) async {
    database.plantDao.deletePlant(plant);
  }
}
