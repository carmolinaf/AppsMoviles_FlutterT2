import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Models/auto.dart';

///Clase para manejar la base de datos autos.db
class DB{

   ///Conexion (o creacion) de base de datos autos.db y tabla autos
  static Future<Database> _openDB() async{
    return openDatabase(join(await getDatabasesPath(), 'Autos.db'),
      onCreate: (db, version){
        return db.execute(
        'CREATE TABLE autos(id INTEGER PRIMARY KEY AUTOINCREMENT, patente TEXT, marca TEXT, precio INTEGER)',
        );
      }, version: 1,
    ); 
  }


  ///Insertar un Auto en la tabla autos
  static Future<int> insert(Auto myAuto) async{
    //referencia a la DB
    Database database = await _openDB(); 

    return database
    .insert('Autos', myAuto.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  ///Retorna todos los Autos de la tabala autos
  static Future<List<Auto>> getAutos() async {
    // Get a reference to the database.
    Database database = await _openDB(); 
    // Query the table for all the Auto's.
    final List<Map<String, dynamic>> maps = await database.query('Autos');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Auto(
        id: maps[i]['id'],
        patente: maps[i]['patente'],
        marca: maps[i]['marca'],
        precio: maps[i]['precio'],
      );
    });
  }


  //Eliminar un Auto de la tabla autos
  static Future<void> delete(int id) async {
    // Get a reference to the database.
    Database database = await _openDB(); 
    // Remove the Auto from the database.
    await database.delete('autos',
      // Use a `where` clause to delete a specific auto.
      where: 'id = ?',
      // Pass the Auto's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


}