// Package imports:
import 'package:floor/floor.dart';

@entity
class PlantType {
  @primaryKey
  final int id;
  final String type;

  PlantType(this.id, this.type);
}
