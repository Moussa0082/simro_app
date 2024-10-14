import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/models/Commune.dart';
import 'package:simro/models/Enquete.dart';
import 'package:simro/models/Enquete_Collecte.dart';
import 'package:simro/models/Enquete_Grossiste.dart';
import 'package:simro/models/Marche.dart';
import 'package:simro/models/Prix_Marche_Collecte.dart';
import 'package:simro/models/Prix_Marche_Consommation.dart';
import 'package:simro/models/Prix_Marche_Consommation_New.dart';
import 'package:simro/models/Prix_Marche_Grossiste.dart';
import 'package:simro/models/Produit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseService extends ChangeNotifier{
  static final LocalDatabaseService _instance = LocalDatabaseService._();
   Database? _database;

  LocalDatabaseService._();

  factory LocalDatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }
  //  Future<Database> get database async {
  //   if (_database != null) return _database!;

  //   // Supprimez la base de données pour la recréer (si nécessaire)
  //   await deleteDatabase();
    
  //   _database = await _initDB();
  //   return _database!;
  // }

 Future<Database> initDB() async {
  String path = join(await getDatabasesPath(), 'collecte.db');
  return await openDatabase(
    path,
    version: 2,
    // version: 2, // Augmentez la version de la base de données
onCreate: (db, version) async {
  // _onUpgrade(db, 1, 2);
      // Création de la table enquete_collecte
      await db.execute('''CREATE TABLE enquete_collecte (
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
      )''');

      await db.execute('''
        CREATE TABLE marche (
          id_marche INTEGER PRIMARY KEY AUTOINCREMENT,
          code_marche TEXT, 
          nom_marche TEXT,
          type_marche TEXT,
          jour_marche TEXT,
          localite TEXT,
          longitude TEXT,
          latitude TEXT,
          superficie REAL,
          description TEXT,
          commune TEXT,
          collecteur TEXT,
          id_personnel TEXT,
          date_enregistrement TEXT,
          modifier_le TEXT,
          modifier_par TEXT
        )
      ''');


//Produit table
          await db.execute('''
        CREATE TABLE produit (
          id_produit INTEGER PRIMARY KEY AUTOINCREMENT,
          code_produit TEXT,
          affichage_ecran INTEGER,
          filiere TEXT,
          image TEXT,
          nom_produit TEXT,
          famille_produit INTEGER,
          forme_produit INTEGER,
          origine_produit INTEGER,
          categorie_produit INTEGER,
          date_enregistrement TEXT,
          id_personnel TEXT,
          etat TEXT,
          modifier_le TEXT,
          modifier_par TEXT
        )
      ''');


       // Création de la table prix_marche_collecte
      await db.execute('''
        CREATE TABLE prix_marche_collecte (
          id_fiche INTEGER PRIMARY KEY AUTOINCREMENT,
          enquete INTEGER,
          produit TEXT,
          isSynced INTEGER,  -- Remplacez BOOLEAN par INTEGER (0 ou 1 pour représenter false/true)
          unite INTEGER,
          poids_unitaire REAL,
          montant_achat REAL,
          prix_fg_kg REAL,
          localite_origine TEXT,
          distance_origine_marche REAL,
          montant_transport INTEGER,
          etat_route TEXT,
          quantite_collecte REAL,
          client_principal INTEGER,
          fournisseur_principal INTEGER,
          niveau_approvisionement INTEGER,
          app_mobile INTEGER,
          observation TEXT,
          statut INTEGER,
          id_personnel TEXT,
          date_enregistrement TEXT,
          modifier_le TEXT,
          modifier_par TEXT
        )
      ''');

       
        // Création de la table enquete_grossiste
      await db.execute('''
        CREATE TABLE enquete_grossiste (
          id_enquete INTEGER PRIMARY KEY AUTOINCREMENT,
          isSynced INTEGER,  -- Remplacez BOOLEAN par INTEGER (0 ou 1 pour représenter false/true)
          num_fiche TEXT,
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

      
       // Création de la table enquete_simple
      await db.execute('''CREATE TABLE enquete (
        id_enquete INTEGER PRIMARY KEY AUTOINCREMENT,
        isSynced INTEGER,  -- Remplacez BOOLEAN par INTEGER (0 ou 1 pour représenter false/true)
        marche TEXT,
        collecteur int,
        statut TEXT,
        date_enquete TEXT,
        observation TEXT
      )''');

    // Création de la table new_prix_marche_consommation
      await db.execute('''
        CREATE TABLE new_prix_marche_consommation (
          id_fiche INTEGER PRIMARY KEY AUTOINCREMENT,
          enquete INTEGER,
          produit TEXT,
          unite INTEGER,
          isSynced INTEGER,
          poids_unitaire REAL,
          prix_mesure REAL,
          prix_kg_litre REAL,
          niveau_approvisionement INTEGER,
          observation TEXT,
          document TEXT,
          app_mobile INTEGER,
          statut INTEGER,
          id_personnel TEXT,
          date_enregistrement TEXT,
          modifier_le TEXT,
          modifier_par TEXT
        )
      ''');


      // Création de la table prix_marche_grossiste
      await db.execute('''
        CREATE TABLE prix_marche_grossiste (
          id_fiche INTEGER PRIMARY KEY AUTOINCREMENT,
          enquete INTEGER,
          grossiste TEXT,
          produit TEXT,
          unite_stock INTEGER,
          nombre_unite_stock REAL,
          poids_moyen_unite_stock REAL,
          poids_stock REAL,
          unite_achat INTEGER,
          isSynced INTEGER,
          nombre_unite_achat REAL,
          poids_moyen_unite_achat REAL,
          poids_total_achat REAL,
          localite_achat TEXT,
          fournisseur_achat INTEGER,
          unite_vente INTEGER,
          nombre_unite_vente REAL,
          poids_moyen_unite_vente REAL,
          poids_total_unite_vente REAL,
          prix_unitaire_vente INTEGER,
          client_vente INTEGER,
          localite_vente TEXT,
          app_mobile INTEGER,
          observation TEXT,
          statut INTEGER,
          id_personnel TEXT,
          date_enregistrement TEXT,
          modifier_le TEXT,
          modifier_par TEXT
        )
      ''');

       
  
    },
    
     onUpgrade: (db, oldVersion, newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE commune (
        id_commune INTEGER PRIMARY KEY AUTOINCREMENT,
        code_commune TEXT,
        nom_commune TEXT,
        abrege_commune TEXT,
        departement TEXT,
        prefecture INTEGER,
        etat TEXT,
        id_personnel TEXT,
        date_enregistrement TEXT,
        modifier_le TEXT,
        modifier_par TEXT
      )
    ''');
    }
  },
      //   onUpgrade: (db, oldVersion, newVersion) async {
      // if (oldVersion < 2) {
      //   // Supprimer et recréer la table prix_marche_consommation
      //   await db.execute('DROP TABLE IF EXISTS prix_marche_consommation');
      //   await db.execute('''
      //     CREATE TABLE prix_marche_consommation (
      //       id_fiche INTEGER PRIMARY KEY AUTOINCREMENT,
      //       enquete INTEGER,
      //       produit TEXT,
      //       unite INTEGER,
      //       isSynced INTEGER,
      //       poids_unitaire REAL,
      //       prix_mesure REAL,
      //       prix_kg_litre REAL,
      //       niveau_approvisionement INTEGER,
      //       observation TEXT,
      //       document TEXT,
      //       app_mobile INTEGER,
      //       statut INTEGER,
      //       id_personnel TEXT,
      //       date_enregistrement TEXT,
      //       modifier_le TEXT,
      //       modifier_par TEXT
      //     )
      //   ''');
      // }
      //   }


  );
}

Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < newVersion) {
    // Supprimer l'ancienne table
    await db.execute('DROP TABLE IF EXISTS prix_marche_consommation');

    // Créer la nouvelle table avec la colonne renommée
    await db.execute('''
      CREATE TABLE prix_marche_consommation (
        id_fiche INTEGER PRIMARY KEY AUTOINCREMENT,
        enquete INTEGER,
        produit TEXT,
        unite INTEGER,
        isSynced INTEGER,
        poids_unitaire REAL,
        prix_mesure REAL,
        prix_kg_litre REAL,
        niveau_approvisionement INTEGER,
        observation TEXT,
        document TEXT,
        app_mobile INTEGER,  -- Colonne renommée ici
        statut INTEGER,
        id_personnel TEXT,
        date_enregistrement TEXT,
        modifier_le TEXT,
        modifier_par TEXT
      )
    ''');
    
  }

  
}


 // Méthode pour supprimer et recréer la table marche
  Future<void> resetMarcheTable() async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS marche'); // Supprime la table si elle existe
    await db.execute('''
        CREATE TABLE marche (
          id_marche INTEGER PRIMARY KEY AUTOINCREMENT,
          code_marche TEXT, 
          nom_marche TEXT,
          type_marche TEXT,
          jour_marche TEXT,
          localite TEXT,
          longitude TEXT,
          latitude TEXT,
          superficie REAL,
          description TEXT,
          commune INTEGER,
          collecteur TEXT,
          id_personnel TEXT,
          date_enregistrement TEXT,
          modifier_le TEXT,
          modifier_par TEXT
        )
      '''); // Recréation de la table avec les bonnes colonnes
  }
// Future<Database> initDB() async {
//   String path = join(await getDatabasesPath(), 'collecte.db');
//   return await openDatabase(
//     path,
//     version: 2,  // Augmentez la version pour forcer l'upgrade
//     onCreate: (db, version) async {
//       // Création de la table enquete_collecte seulement
//       await db.execute('''CREATE TABLE enquete_collecte (
//         id_enquete INTEGER PRIMARY KEY AUTOINCREMENT,
//         num_fiche TEXT,
//         isSynced INTEGER,  -- Remplacez BOOLEAN par INTEGER (0 ou 1 pour représenter false/true)
//         marche TEXT,
//         collecteur TEXT,
//         date_enquete TEXT,
//         date_enregistrement TEXT,
//         id_personnel TEXT,
//         etat TEXT,
//         modifier_le TEXT,
//         modifier_par TEXT
//       )''');
//     },
//     onUpgrade: (db, oldVersion, newVersion) async {
//       if (oldVersion < 2) {
//         // Supprimer la table 'marche' si elle existe
//         await db.execute('DROP TABLE IF EXISTS marche');
//       }

//       // Vous pouvez ajouter d'autres vérifications pour d'autres tables si nécessaire
//     },
//   );
// }




   // Méthode pour récupérer tous les marchés de la base locale
 Future<List<Marche>> getAllMarche() async {
  final db = await database;
  final List<Map<String, dynamic>> marcheMapList = await db.query('marche');

  // Conversion en liste de Marche
  return marcheMapList.map((map) {
    return Marche.fromMap(map);
  }).toList();
 }


  


  // Méthode pour ajouter un marché dans la base locale
  Future<void> addMarche(Marche marche) async {
    final db = await database;

    await db.insert(
      'marche',
      marche.toMap(),
    );
  }

  // Méthode pour supprimer un marché de la base locale
  Future<void> deleteMarche(int id_marche) async {
    final db = await database;

    await db.delete(
      'marche',
      where: 'id_marche = ?',
      whereArgs: [id_marche],
    );
  }
  
   Future<List<Produit>> getAllProduits() async {
    final db = await database;
    final result = await db.query('produit');
    return result.map((e) => Produit.fromMap(e)).toList();
  }

   Future<List<Commune>> getAllCommunes() async {
    final db = await database;
    final result = await db.query('commune');
    return result.map((e) => Commune.fromMap(e)).toList();
  }
  

 Future<void> deleteDatabase() async {
  // String path = join(await getDatabasesPath(), 'enquete_collecte.db');
  await deleteDatabase();
}


  Future<void> checkTableStructure() async {
  final db = await database;
  final List<Map<String, dynamic>> result = await db.rawQuery("PRAGMA table_info(enquete_collecte)");
  
  for (var row in result) {
    print('Column: ${row['name']}, Type: ${row['type']}');
  }
}


  Future<void> insertProduit(Produit produit) async {
    final db = await database;
    await db.insert('produit', produit.toMap());
  }

  Future<void> insertCommune(Commune commune) async {
    final db = await database;
    await db.insert('commune', commune.toMap());
  }

  Future<void> insertEnquete(EnqueteCollecte enquete) async {
    final db = await database;
    await db.insert('enquete_collecte', enquete.toMap());
    Get.snackbar("Succes", "Ajouter avec succès", snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> insertEnqueteCollecte(EnqueteCollecte enquete) async {
    final db = await database;
    await db.insert('enquete_collecte', enquete.toMap());
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

 //Enquete consommation crud
  Future<void> insertEnqueteConsommation(Enquete enquete) async {
    final db = await database;
    await db.insert('enquete', enquete.toMap());
    Get.snackbar("Succes", "Ajouter avec succès", snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> insertEnqueteConsommationn(Enquete enquete) async {
    final db = await database;
    await db.insert('enquete', enquete.toMap());
  }

  Future<List<Enquete>> getAllEnquetesConsommation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('enquete');
    return List.generate(maps.length, (i) => Enquete.fromMap(maps[i]));
  }

  Future<void> updateEnqueteConsommation(Enquete enquete) async {
    final db = await database;
    await db.update(
      'enquete',
      enquete.toMap(),
      where: 'id_enquete = ?',
      whereArgs: [enquete.id_enquete],
    );
  Get.snackbar("Succes", "Modifier avec succès", snackPosition: SnackPosition.BOTTOM);

  }

 // Suppression par ID
  Future<void> deleteEnqueteConsommation(int id) async {
  final db = await database;

  // Supprime l'enquête dont l'ID correspond
  await db.delete(
    'enquete',
    where: 'id_enquete = ?',
    whereArgs: [id],
  );
    Get.snackbar("Succes", "Supprimer avec succès", snackPosition: SnackPosition.BOTTOM);
}

 //Enquete consommation grossiste
  Future<void> insertEnqueteGrossiste(EnqueteGrossiste enquete) async {
    final db = await database;
    await db.insert('enquete_grossiste', enquete.toMap());
    Get.snackbar("Succes", "Ajouter avec succès", snackPosition: SnackPosition.BOTTOM);
  }

 //Enquete consommation grossiste
  Future<void> insertEnqueteGrossistee(EnqueteGrossiste enquete) async {
    final db = await database;
    await db.insert('enquete_grossiste', enquete.toMap());
  }

  Future<List<EnqueteGrossiste>> getAllEnqueteGrossiste() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('enquete_grossiste');
    return List.generate(maps.length, (i) => EnqueteGrossiste.fromMap(maps[i]));
  }

  Future<void> updateEnqueteGrossiste(EnqueteGrossiste enquete) async {
    final db = await database;
    await db.update(
      'enquete_grossiste',
      enquete.toMap(),
      where: 'id_enquete = ?',
      whereArgs: [enquete.id_enquete],
    );
  Get.snackbar("Succes", "Modifier avec succès", snackPosition: SnackPosition.BOTTOM);

  }

 // Suppression par ID
  Future<void> deleteEnqueteGrossiste(int id) async {
  final db = await database;

  // Supprime l'enquête dont l'ID correspond
  await db.delete(
    'enquete_grossiste',
    where: 'id_enquete = ?',
    whereArgs: [id],
  );
    Get.snackbar("Succes", "Supprimer avec succès", snackPosition: SnackPosition.BOTTOM);
}

 //Marche collecte crud
  Future<void> insertPrixMarcheCollecte(PrixMarcheCollecte prixMarcheCollecte) async {
    final db = await database;
    await db.insert('prix_marche_collecte', prixMarcheCollecte.toMap());
    Get.snackbar("Succes", "Ajouter avec succès", snackPosition: SnackPosition.BOTTOM);
  }

  Future<List<PrixMarcheCollecte>> getAllPrixMarcheCollecte() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('prix_marche_collecte');
    return List.generate(maps.length, (i) => PrixMarcheCollecte.fromMap(maps[i]));
  }

  Future<void> updatePrixMarcheCollecte(PrixMarcheCollecte prixMarcheCollecte) async {
    final db = await database;
    await db.update(
      'prix_marche_collecte',
      prixMarcheCollecte.toMap(),
      where: 'id_enquete = ?',
      whereArgs: [prixMarcheCollecte.id_fiche],
    );
  Get.snackbar("Succes", "Modifier avec succès", snackPosition: SnackPosition.BOTTOM);

  }

 // Suppression par ID
  Future<void> deletePrixMarcheCollecte(int id) async {
  final db = await database;

  // Supprime  dont l'ID correspond
  await db.delete(
    'prix_marche_collecte',
    where: 'id_fiche = ?',
    whereArgs: [id],
  );
    Get.snackbar("Succes", "Supprimer avec succès", snackPosition: SnackPosition.BOTTOM);
}

 //Marche grossiste crud
  Future<void> insertPrixMarcheGrossiste(PrixMarcheGrossiste prixMarcheGrossiste) async {
    final db = await database;
    await db.insert('prix_marche_grossiste', prixMarcheGrossiste.toMap());
    Get.snackbar("Succes", "Ajouter avec succès", snackPosition: SnackPosition.BOTTOM);
  }

  Future<List<PrixMarcheGrossiste>> getAllPrixMarcheGrossiste() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('prix_marche_grossiste');
    return List.generate(maps.length, (i) => PrixMarcheGrossiste.fromMap(maps[i]));
  }

  Future<void> updatePrixMarcheGrossiste(PrixMarcheGrossiste prixMarcheGrossiste) async {
    final db = await database;
    await db.update(
      'prix_marche_grossiste',
      prixMarcheGrossiste.toMap(),
      where: 'id_fiche = ?',
      whereArgs: [prixMarcheGrossiste.id_fiche],
    );
  Get.snackbar("Succes", "Modifier avec succès", snackPosition: SnackPosition.BOTTOM);

  }

 // Suppression par ID
  Future<void> deletePrixMarcheGrossiste(int id) async {
  final db = await database;

  // Supprime  dont l'ID correspond
  await db.delete(
    'prix_marche_grossiste',
    where: 'id_fiche = ?',
    whereArgs: [id],
  );
    Get.snackbar("Succes", "Supprimer avec succès", snackPosition: SnackPosition.BOTTOM);
  }


 //Marche consommation crud
  Future<void> insertPrixMarcheConsommation(PrixMarcheConsommation prixMarcheConsommation) async {
    final db = await database;
    await db.insert('new_prix_marche_consommation', prixMarcheConsommation.toMap());
    Get.snackbar("Succes", "Ajouter avec succès", snackPosition: SnackPosition.BOTTOM);
  }

  Future<List<PrixMarcheConsommation>> getAllPrixMarcheConsommation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('new_prix_marche_consommation');
    return List.generate(maps.length, (i) => PrixMarcheConsommation.fromMap(maps[i]));
  }

  Future<void> updatePrixMarcheConsommation(PrixMarcheConsommation prixMarcheConsommation) async {
    final db = await database;
    await db.update(
      'new_prix_marche_consommation',
      prixMarcheConsommation.toMap(),
      where: 'id_fiche = ?',
      whereArgs: [prixMarcheConsommation.id_fiche],
    );
  Get.snackbar("Succes", "Modifier avec succès", snackPosition: SnackPosition.BOTTOM);

  }

 // Suppression par ID
  Future<void> deletePrixMarcheConsommation(int id) async {
  final db = await database;

  // Supprime  dont l'ID correspond
  await db.delete(
    'new_prix_marche_consommation',
    where: 'id_fiche = ?',
    whereArgs: [id],
  );
    Get.snackbar("Succes", "Supprimer avec succès", snackPosition: SnackPosition.BOTTOM);
  }


 // Supprimer tous les produits
  Future<void> deleteAllProduits() async {
    final db = await database;
    await db.delete('produit');
  }

 // Supprimer tous les marches
  Future<void> deleteAllMarches() async {
    final db = await database;
    await db.delete('marche');
  }

 // Supprimer tous les communes
  Future<void> deleteAllCommunes() async {
    final db = await database;
    await db.delete('commune');
  }
 // Supprimer tous les enquete_collecte
  Future<void> deleteAllEnqueteCollecte() async {
    final db = await database;
    await db.delete('enquete_collecte');
  }

 // Supprimer tous les enquete_grossiste
  Future<void> deleteAllEnqueteGrossiste() async {
    final db = await database;
    await db.delete('enquete_grossiste');
  }


 // Supprimer tous les enquête consommation
  Future<void> deleteAllEnqueteConsommation() async {
    final db = await database;
    await db.delete('enquete');
  }

}
