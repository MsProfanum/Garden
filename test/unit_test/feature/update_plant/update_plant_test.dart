import 'package:flutter_test/flutter_test.dart';
import 'package:garden/database/datasource.dart';
import 'package:garden/database/plant/plant_entity.dart';

void main() async {
  DataSource dataSource = await DataSource.newInstance();
  Plant mockPlant = Plant(0, 'Aloe', 'succulent', 100);

  setUp(() async {
    await dataSource.insertPlant(mockPlant);
  });

  tearDownAll(() async {
    await dataSource.database.close();
  });

  test('Delete the plant', () async {
    await dataSource.deletePlant(mockPlant);
    Plant? plantFromDatabase = await dataSource.findPlantById(mockPlant.id);
    expect(plantFromDatabase, null);
  });
  test('Change plant name', () async {
    Plant updatedPlant = Plant(
        mockPlant.id, 'New plant', mockPlant.type, mockPlant.plantingDate);
    await dataSource.updatePlant(updatedPlant);
    Plant? newPlantFromDatabase =
        await dataSource.findPlantById(updatedPlant.id);

    assert(newPlantFromDatabase != null);

    expect(newPlantFromDatabase!.id, mockPlant.id);
    expect(newPlantFromDatabase.name, updatedPlant.name);
    expect(newPlantFromDatabase.type, mockPlant.type);
    expect(newPlantFromDatabase.plantingDate, mockPlant.plantingDate);

    await dataSource.deletePlant(newPlantFromDatabase);
  });
  test('Change plant type', () async {
    Plant updatedPlant =
        Plant(mockPlant.id, mockPlant.name, 'aquatic', mockPlant.plantingDate);
    await dataSource.updatePlant(updatedPlant);
    Plant? newPlantFromDatabase =
        await dataSource.findPlantById(updatedPlant.id);

    assert(newPlantFromDatabase != null);

    expect(newPlantFromDatabase!.id, mockPlant.id);
    expect(newPlantFromDatabase.name, mockPlant.name);
    expect(newPlantFromDatabase.type, updatedPlant.type);
    expect(newPlantFromDatabase.plantingDate, mockPlant.plantingDate);

    await dataSource.deletePlant(newPlantFromDatabase);
  });
  test('Change plant datetime', () async {
    Plant updatedPlant = Plant(mockPlant.id, mockPlant.name, mockPlant.type, 0);
    await dataSource.updatePlant(updatedPlant);
    Plant? newPlantFromDatabase =
        await dataSource.findPlantById(updatedPlant.id);

    assert(newPlantFromDatabase != null);

    expect(newPlantFromDatabase!.id, mockPlant.id);
    expect(newPlantFromDatabase.name, mockPlant.name);
    expect(newPlantFromDatabase.type, mockPlant.type);
    expect(newPlantFromDatabase.plantingDate, updatedPlant.plantingDate);

    await dataSource.deletePlant(newPlantFromDatabase);
  });
}
