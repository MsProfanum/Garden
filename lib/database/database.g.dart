// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PlantDao? _plantDaoInstance;

  PlantTypeDao? _plantTypeDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Plant` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `plantingDate` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlantType` (`id` INTEGER NOT NULL, `type` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PlantDao get plantDao {
    return _plantDaoInstance ??= _$PlantDao(database, changeListener);
  }

  @override
  PlantTypeDao get plantTypeDao {
    return _plantTypeDaoInstance ??= _$PlantTypeDao(database, changeListener);
  }
}

class _$PlantDao extends PlantDao {
  _$PlantDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _plantInsertionAdapter = InsertionAdapter(
            database,
            'Plant',
            (Plant item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'plantingDate': item.plantingDate
                }),
        _plantUpdateAdapter = UpdateAdapter(
            database,
            'Plant',
            ['id'],
            (Plant item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'plantingDate': item.plantingDate
                }),
        _plantDeletionAdapter = DeletionAdapter(
            database,
            'Plant',
            ['id'],
            (Plant item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'plantingDate': item.plantingDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Plant> _plantInsertionAdapter;

  final UpdateAdapter<Plant> _plantUpdateAdapter;

  final DeletionAdapter<Plant> _plantDeletionAdapter;

  @override
  Future<List<Plant>> findAllPlants() async {
    return _queryAdapter.queryList('SELECT * FROM Plant',
        mapper: (Map<String, Object?> row) => Plant(
            row['id'] as int,
            row['name'] as String,
            row['type'] as String,
            row['plantingDate'] as int));
  }

  @override
  Future<Plant?> findPlantById(int id) async {
    return _queryAdapter.query('SELECT * FROM Plant WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Plant(
            row['id'] as int,
            row['name'] as String,
            row['type'] as String,
            row['plantingDate'] as int),
        arguments: [id]);
  }

  @override
  Future<Plant?> findPlantByName(String name) async {
    return _queryAdapter.query('SELECT * FROM Plant WHERE name = ?1',
        mapper: (Map<String, Object?> row) => Plant(
            row['id'] as int,
            row['name'] as String,
            row['type'] as String,
            row['plantingDate'] as int),
        arguments: [name]);
  }

  @override
  Future<List<Plant>?> findPlantsByType(String type) async {
    return _queryAdapter.queryList('SELECT * FROM Plant WHERE type = ?1',
        mapper: (Map<String, Object?> row) => Plant(
            row['id'] as int,
            row['name'] as String,
            row['type'] as String,
            row['plantingDate'] as int),
        arguments: [type]);
  }

  @override
  Future<void> insertPlant(Plant plant) async {
    await _plantInsertionAdapter.insert(plant, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePlant(Plant plant) async {
    await _plantUpdateAdapter.update(plant, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePlant(Plant plant) async {
    await _plantDeletionAdapter.delete(plant);
  }
}

class _$PlantTypeDao extends PlantTypeDao {
  _$PlantTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<PlantType>> findAllPlantTypes() async {
    return _queryAdapter.queryList('SELECT * FROM PlantType',
        mapper: (Map<String, Object?> row) =>
            PlantType(row['id'] as int, row['type'] as String));
  }

  @override
  Future<PlantType?> findPlantTypeById(int id) async {
    return _queryAdapter.query('SELECT * FROM PlantType WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            PlantType(row['id'] as int, row['type'] as String),
        arguments: [id]);
  }

  @override
  Future<PlantType?> findPlantTypeByType(String type) async {
    return _queryAdapter.query('SELECT * FROM PlantType WHERE type = ?1',
        mapper: (Map<String, Object?> row) =>
            PlantType(row['id'] as int, row['type'] as String),
        arguments: [type]);
  }
}
