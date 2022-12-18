import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  static Future<void> openDB() async {
    _database = await openDatabase(join(await getDatabasesPath(), 'ace_plus.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS userData (userDataJson TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS userDetailData (userDetailDataJson TEXT)');
    });
  }

  static Database? getDB() {
    return _database;
  }
}
