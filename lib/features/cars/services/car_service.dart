import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/car.dart';

class CarService {
  final String dbName = "cars.db";
  final String tableName = "cars";
  final String idColumn = "id";
  final String modelColumn = "model";
  final String yearColumn = "year";
  late final Database _database;

  CarService._singleton();

  static final _constructor = CarService._singleton();

  factory CarService() {
    return _constructor;
  }

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$dbName";
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    // create table
    final String query = """
        CREATE TABLE $tableName
        (
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $modelColumn TEXT NOT NULL,
          $yearColumn INTEGER NOT NULL
        )
""";
    await db.execute(query);
  }

  Future<List<Car>> get() async {
    final data = await _database.query(tableName);
    List<Car> cars = [];
    for (var d in data) {
      final car = Car(
        id: d[idColumn] as int,
        model: d[modelColumn] as String,
        year: d[yearColumn] as int,
      );

      cars.add(car);
    }

    return cars;
  }

  Future<void> insert({
    required String model,
    required int year,
  }) async {
    await _database.insert(tableName, {
      modelColumn: model,
      yearColumn: year,
    });
  }

  Future<void> delete(int carId) async {
    await _database.delete(tableName, where: "id=$carId");
  }
}
