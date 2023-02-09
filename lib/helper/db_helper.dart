import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String studentsTable = "students";
  final String fieldId = "ID";
  final String fieldName = "NAME";
  final String fieldAge = "AGE";
  final String fieldCourse = "COURSE";
  final String fieldImage = "IMAGE";

  late Database database;

  Future<void> createDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, "demo.db");

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String query =
          "CREATE TABLE IF NOT EXISTS $studentsTable ($fieldId INTEGER PRIMARY KEY AUTOINCREMENT,$fieldName TEXT,$fieldAge INTEGER,$fieldCourse TEXT,$fieldImage BLOB);";
      await db.execute(query);
    });
  }

  Future<int> insertData(
      {required String name,
      required int age,
      required String course,
      Uint8List? image}) async {
    await createDB();
    String query =
        "INSERT INTO $studentsTable ($fieldName,$fieldAge,$fieldCourse,$fieldImage) VALUES (?, ?, ?, ?);";
    List argy = [name, age, course, image];
    int id = await database.rawInsert(query, argy);
    return id;
  }

  Future<List<Map<String, dynamic>>> fetchAllData() async {
    await createDB();
    String query = "SELECT * FROM $studentsTable;";
    List<Map<String, dynamic>> allData = await database.rawQuery(query);
    return allData;
  }

  Future<int> updateData(
      {String? name,
      int? age,
      String? course,
      Uint8List? image,
      required int id}) async {
    await createDB();
    String query =
        "UPDATE $studentsTable SET $fieldName = ?, $fieldAge = ?, $fieldCourse = ?, $fieldImage = ? WHERE $fieldId = ?;";
    List argy = [name, age, course, image, id];
    int item = await database.rawUpdate(query, argy);
    return item;
  }

  Future<int> deleteData({required int id}) async {
    await createDB();
    String query = "DELETE FROM $studentsTable WHERE $fieldId = ?;";
    List argy = [id];
    int item = await database.rawDelete(query, argy);
    return item;
  }
}
