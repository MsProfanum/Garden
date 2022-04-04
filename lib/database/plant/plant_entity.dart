// Package imports:
import 'package:floor/floor.dart';

@entity
class Plant {
  @primaryKey
  final int id;
  final String name;
  final String type;
  final int plantingDate;

  Plant(this.id, this.name, this.type, this.plantingDate);
}
