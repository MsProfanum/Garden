import 'package:flutter_test/flutter_test.dart';
import 'package:garden/database/datasource.dart';
import 'package:garden/database/plant/plant_entity.dart';

main() async {
  DataSource dataSource = await DataSource.newInstance();
  Plant mockPlant = Plant(0, 'Aloe', 'succulent', 100);

  tearDownAll(() async {
    await dataSource.deletePlant(mockPlant);
    await dataSource.database.close();
  });

  test('Add plant', () async {
    List<Plant> plantList =
        await dataSource.findPlants(pageSize: 10, offset: 0);
    expect(plantList.length, 0);
    await dataSource.insertPlant(mockPlant);
    plantList = await dataSource.findPlants(pageSize: 10, offset: 0);
    expect(plantList.length, 1);
  });
}
