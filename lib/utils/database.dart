import 'package:bill_calc/models/reading.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

//When we call this file it will check if instance of this file already
//exists, if it does it is gonna return that instance, else it will create
//a new instance of this object.

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'bill_reading.db'),
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE readingTable(
              id TEXT PRIMARY KEY, date TEXT, initial_reading TEXT, final_reading TEXT, billAmount TEXT
            )
          ''');
      },
      version: 1,
    );
  }

  newEntry(Reading newEntry) async {
    final db = await database;
    var res = await db.rawInsert('''
    INSERT INTO readingTable(
      id, date, initial_reading, final_reading, billAmount
    ) VALUES (?, ?, ?, ?, ?)
    ''', [
      newEntry.id,
      newEntry.date,
      newEntry.initial_reading,
      newEntry.final_reading,
      newEntry.billAmount
    ]);

    return res;
  }

  Future<List<Reading>> getAllReadings() async {
    List<Reading> readings = [];
    final db = await database;
    var res = (await db.query("readingTable"));

    // res.forEach((element) {
    //   print("$element is element");
    //   print(readings);
    // });

    res.forEach((element) {
      var readingElement = Reading.fromJson(element);
      // print("runs");
      readings.add(readingElement);
    });

    print(readings.isEmpty.toString());

    return readings;
  }
}
