import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/models/Enquete_Collecte.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseService extends ChangeNotifier{
  static final LocalDatabaseService _instance = LocalDatabaseService._();
  static Database? _database;

  LocalDatabaseService._();

  factory LocalDatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }
  //  Future<Database> get database async {
  //   if (_database != null) return _database!;

  //   // Supprimez la base de données pour la recréer (si nécessaire)
  //   await deleteDatabase();
    
  //   _database = await _initDB();
  //   return _database!;
  // }

Future<Database> _initDB() async {
  String path = join(await getDatabasesPath(), 'enquete_collecte.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE enquete_collecte (
          id_enquete INTEGER PRIMARY KEY AUTOINCREMENT,
          num_fiche TEXT,
          isSynced INTEGER,  -- Remplacez BOOLEAN par INTEGER (0 ou 1 pour représenter false/true)
          marche TEXT,
          collecteur TEXT,
          date_enquete TEXT,
          date_enregistrement TEXT,
          id_personnel TEXT,
          etat TEXT,
          modifier_le TEXT,
          modifier_par TEXT
        )
      ''');
    },
  );
}

 Future<void> deleteDatabase() async {
  String path = join(await getDatabasesPath(), 'enquete_collecte.db');
  await deleteDatabase();
}


  Future<void> checkTableStructure() async {
  final db = await database;
  final List<Map<String, dynamic>> result = await db.rawQuery("PRAGMA table_info(enquete_collecte)");
  
  for (var row in result) {
    print('Column: ${row['name']}, Type: ${row['type']}');
  }
}


  Future<void> insertEnquete(EnqueteCollecte enquete) async {
    final db = await database;
    await db.insert('enquete_collecte', enquete.toMap());
    Get.snackbar("Succes", "Ajouter avec succès", snackPosition: SnackPosition.BOTTOM);
  }

  Future<List<EnqueteCollecte>> getAllEnquetes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('enquete_collecte');
    return List.generate(maps.length, (i) => EnqueteCollecte.fromMap(maps[i]));
  }

  Future<void> updateEnquete(EnqueteCollecte enquete) async {
    final db = await database;
    await db.update(
      'enquete_collecte',
      enquete.toMap(),
      where: 'id_enquete = ?',
      whereArgs: [enquete.id_enquete],
    );
  Get.snackbar("Succes", "Modifier avec succès", snackPosition: SnackPosition.BOTTOM);

  }

 // Suppression par ID
  Future<void> deleteEnqueteCollecte(int id) async {
  final db = await database;

  // Supprime l'enquête dont l'ID correspond
  await db.delete(
    'enquete_collecte',
    where: 'id_enquete = ?',
    whereArgs: [id],
  );
    Get.snackbar("Succes", "Supprimer avec succès", snackPosition: SnackPosition.BOTTOM);

}

}
