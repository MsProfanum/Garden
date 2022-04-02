import 'package:floor/floor.dart';
import 'package:garden/database/plant/plant_entity.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant')
  Future<List<Plant>> findAllPlants();

  @Query('SELECT * FROM Plant WHERE id = :id')
  Future<Plant?> findPlantById(int id);

  @Query('SELECT * FROM Plant WHERE name = :name')
  Future<Plant?> findPlantByName(String name);

  @Query('SELECT * FROM Plant WHERE type = :type')
  Future<List<Plant>?> findPlantsByType(String type);

  @insert
  Future<void> insertPlant(Plant plant);

  @update
  Future<void> updatePlant(Plant plant);

  @delete
  Future<void> deletePlant(Plant plant);
}
