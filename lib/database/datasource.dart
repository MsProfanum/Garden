import 'package:garden/database/database.dart';
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
}
