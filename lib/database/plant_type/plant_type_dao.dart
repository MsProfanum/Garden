import 'package:floor/floor.dart';
import 'package:garden/database/plant_type/plant_type_entity.dart';

@dao
abstract class PlantTypeDao {
  @Query('SELECT * FROM PlantType')
  Future<List<PlantType>> findAllPlantTypes();

  @Query('SELECT * FROM PlantType WHERE id = :id')
  Future<PlantType?> findPlantTypeById(int id);

  @Query('SELECT * FROM PlantType WHERE type = :type')
  Future<PlantType?> findPlantTypeByType(String type);

  @insert
  Future<void> insertPlantType(PlantType plantType);
}
