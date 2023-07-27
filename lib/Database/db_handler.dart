import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:local_foodie/Model/user_class.dart';

class DatabaseHandler {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbLocation = join(path, 'user.db');
    print('DB Path---->' + dbLocation);
    return openDatabase(
      dbLocation,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
      CREATE TABLE User (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fname TEXT NOT NULL,
        lname TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
      },
    );
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initDB();
    for (var usr in users) {
      result = await db.insert('user', usr.toMap());
    }
    return result;
  }

  Future<List<User>> retrieveUsr() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query('User');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<void> deleteUser(String email) async {
    final Database db = await initDB();
    await db.delete(
      'user',
      where: "email = ?",
      whereArgs: [email],
    );
  }
}
