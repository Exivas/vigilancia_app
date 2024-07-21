import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vigilancia_app/models/incidencia.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'incidencias.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidencias(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        fecha TEXT,
        descripcion TEXT,
        fotoPath TEXT,
        audioPath TEXT
      )
    ''');
  }

  Future<int> insertIncidencia(Incidencia incidencia) async {
    Database db = await database;
    return await db.insert('incidencias', incidencia.toMap());
  }

  Future<List<Incidencia>> getIncidencias() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('incidencias');
    return List.generate(maps.length, (i) => Incidencia.fromMap(maps[i]));
  }

  Future<void> deleteAllIncidencias() async {
    Database db = await database;
    await db.delete('incidencias');
  }
}