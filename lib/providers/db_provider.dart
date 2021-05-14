import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_app/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final db =  DBProvider._();

  DBProvider._();

  Future<Database>get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async{
    // path de donde almacenaremos la base de datos

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db' );

    print(path);

    //Crear base de datos

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async{

        await db.execute('''
          create table scans(
            id integer primary key,
            tipo text,
            valor text
          )
        ''');
      }
    );
  }

  Future<int>nuevoScanRaw(ScanModel nuevoScan )async{

    //verificar la base de daos
    final db = await database;

    final res = await db.rawInsert('''
      insert into scans(id,tipo,valor) values(${nuevoScan.id},'${nuevoScan.tipo}','${nuevoScan.valor}')
    ''');

    return res;

  }

  Future<int>nuevoScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());
    print("id del scan insertado: " + res.toString());
    return res;
  }

  Future<ScanModel>getScanById(int id) async{
    final db = await database;

    final res = await db.query('scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty 
            ? ScanModel.fromJson(res.first) 
            : null;
  }
  Future<List<ScanModel>>getAllScans() async{
    final db = await database;

    final res = await db.query('scans');

    return res.isNotEmpty ? res.map((scan)=> ScanModel.fromJson(scan)).toList() :[];
  }
  Future<List<ScanModel>>getAllScansPorTipo(String tipo) async{
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * FROM Scans where tipo = '$tipo'
    ''');

    return res.isNotEmpty ? res.map((scan)=> ScanModel.fromJson(scan)).toList() :[];
  }

  Future<int> updateScan(ScanModel nuevoScan) async{
    final db = await database;
    final res = await db.update('scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

    // Eliminar registros
  Future<int> deleteScan( int id ) async {

    final db  = await database;
    final res = await db.delete('scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {

    final db  = await database;
    final res = await db.rawDelete('DELETE FROM scans');

    print("cantidad de registros eliminados: " + res.toString());
    return res;
  }

}