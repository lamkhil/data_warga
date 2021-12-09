import 'package:data_warga/data/models/anggota.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static late Database instance;

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    instance = await openDatabase(
      join(path, 'app_data.db'),
      onCreate: (database, version) async {
        await Future.wait([
          database.execute(_queryCreateTableAnggota),
          database.execute(_queryCreateTableVariable),
        ]);
        await database.transaction((txn) async {
          await txn.rawInsert(_firstTansaction);
        });
      },
      version: 1,
    );
    return instance;
  }

  final String _queryCreateTableAnggota = '''
              CREATE TABLE ${Anggota.tableName} (
                ${Anggota.kolomNIK} TEXT PRIMARY KEY,
                ${Anggota.kolomNAMA} TEXT NOT NULL,
                ${Anggota.kolomTGLLAHIR} TEXT,
                ${Anggota.kolomNORUMAH} TEXT,
                ${Anggota.kolomRT} TEXT,
                ${Anggota.kolomRW} TEXT,
                ${Anggota.kolomALAMAT} TEXT,
                ${Anggota.kolomJK} INTEGER,
                ${Anggota.kolomPEKERJAAN} INTEGER,
                ${Anggota.kolomSTATUS} INTEGER,
                ${Anggota.kolomDOMISILI} INTEGER
              )
              ''';

  final String _queryCreateTableVariable = '''
  CREATE TABLE variable_tetap (
                RT TEXT,
                RW TEXT,
                KEL TEXT,
                KEC TEXT,
                KOTA TEXT
              )
  ''';

  final String _firstTansaction = '''
  INSERT INTO 'variable_tetap' (RT, RW, KEL, KEC, KOTA)
              VALUES
                ("47", "10", "KEPARAKAN", "MERGANGSAN", "YOGYAKARTA")
  ''';
}
