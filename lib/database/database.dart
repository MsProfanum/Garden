import 'package:floor/floor.dart';
import 'package:garden/database/plant/plant_dao.dart';
import 'package:garden/database/plant/plant_entity.dart';
import 'package:garden/database/plant_type/plant_type_dao.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Plant, PlantType])
abstract class AppDatabase extends FloorDatabase {
  PlantDao get plantDao;
  PlantTypeDao get plantTypeDao;
}
