import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Prix_Marche_Collecte.dart';
import 'package:simro/models/Prix_Marche_Consommation.dart';
import 'package:simro/models/Prix_Marche_Grossiste.dart';
import 'package:simro/models/Produit_Info.dart';
import 'package:http/http.dart' as http;
import 'package:simro/widgets/Snackbar.dart';



class PrixMarcheService extends ChangeNotifier{

   String baseUrl = "all-prix-marche-collecte";
   String baseUrl1 = "prix-marche-collecte";
   String baseUrlG = "prix-marche-grossiste";
   String baseUrlC = "prix-marche-consommation";
   String baseUrl2 = "all-prix-marche-consommation";
   String baseUrl3 = "all-prix-marche-grossiste";
   String prixProduitUrl = "liste-prix-moyen-par-produit/";
  
       List<PrixInfo> prixInfoList = [];
       List<PrixMarcheCollecte> prixMarcheCollecteList = [];
       List<PrixMarcheGrossiste> prixMarcheGrossisteList = [];
       List<PrixMarcheConsommation> prixMarcheConsommationList = [];
      //  List<PrixMarcheGrossiste> prixMarcheGrossisteList = [];
      //  List<PrixInfo> prixInfoList = [];


   Future<List<PrixInfo>> fetchPrixInfo() async {
    final response = await http.get(Uri.parse("$apiUrl/$prixProduitUrl"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      prixInfoList =
          body.map((item) => PrixInfo.fromMap(item)).toList();
      print(response.body);
      return prixInfoList;
    } else {
      
      print('Échec de la requête lors de la recuperaion des prix produits avec le code d\'état: ${response.statusCode}');
      return prixInfoList = [];
    }
  }

    Future<List<PrixMarcheCollecte>> fetchPrixMarcheCollecte() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl/"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      prixMarcheCollecteList =
          body.map((item) => PrixMarcheCollecte.fromMap(item)).toList();
      print(response.body);
      return prixMarcheCollecteList;
    } else {
      
      print('Échec de la requête lors de la recuperaion des prix marché collecter avec le code d\'état: ${response.statusCode}');
      return prixMarcheCollecteList = [];
    }
  }

    Future<List<PrixMarcheGrossiste>> fetchPrixMarcheGrossiste() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrlG/"));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      prixMarcheGrossisteList =
          body.map((item) => PrixMarcheGrossiste.fromMap(item)).toList();
      print(response.body);
      return prixMarcheGrossisteList;
    } else {
      
      print('Échec de la requête lors de la recuperaion des prix marché grossiste avec le code d\'état: ${response.statusCode}');
      return prixMarcheGrossisteList = [];
    }
  }


    Future<List<PrixMarcheConsommation>> fetchPrixMarcheConsommation() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrlC/"));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      prixMarcheConsommationList =
          body.map((item) => PrixMarcheConsommation.fromMap(item)).toList();
      print(response.body);
      return prixMarcheConsommationList;
    } else {
      
      print('Échec de la requête lors de la recuperaion des prix marché consommation avec le code d\'état: ${response.statusCode}');
      return prixMarcheConsommationList = [];
    }
  }

  Future<void> addPrixMarcheCollecte({
  required int enquete,
  required String produit,
  required int unite,
  required double poids_unitaire,
  required double montant_achat,
  required double prix_fg_kg,
  required double distance_origine_marche,
  required double montant_transport,
  required int app_mobile,
  required double quantite_collecte,
  required int client_principal,
  required int fournisseur_principal,
  required int niveau_approvisionement,
  required int statut,
  required String localite_origine,
  required String etat_route,
  // required String observation,
  required String id_personnel,
}) async {
  var addPrixMarcheCollecte = jsonEncode({
    'id_personnel': id_personnel,//
    'enquete': enquete,//
    'produit': produit,//
    'poids_unitaire': poids_unitaire,//
    'montant_achat': montant_achat,//
    'prix_fg_kg': prix_fg_kg,//
    'localite_origine': localite_origine,//
    'distance_origine_marche': distance_origine_marche,//
    'montant_transport': montant_transport,//
    'etat_route': etat_route,//
    'statut': statut,//
    // 'observation': observation,//
    'quantite_collecte': quantite_collecte,//
    'client_principal': client_principal,//
    'fournisseur_principal': fournisseur_principal,//
    'niveau_approvisionement': niveau_approvisionement,//
    'app_mobile': app_mobile,//
  });

  try {
    final response = await http.post(
      Uri.parse("$apiUrl/$baseUrl1/create/"),
      headers: {'Content-Type': 'application/json'},
      body: addPrixMarcheCollecte,
    );

    print('Request Body: $addPrixMarcheCollecte');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet envoyé avec succès");
      Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      // Capturer et afficher l'erreur exacte
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      String errorMessage = errorResponse['message'] ?? 'Une erreur s\'est produite.';
      Snack.error(titre: "Erreur", message: errorMessage);
      throw Exception("Erreur: ${response.statusCode} - $errorMessage");
    }
  } catch (e) {
    Snack.error(titre: "Erreur", message: "Une erreur s'est produite, veuillez réessayer plus tard.");
    print('Erreur lors de l\'ajout: $e');
  }
}


  Future<void> addPrixMarcheGrossiste({
  required int enquete,
  required String produit,
  required int unite,
  required int id_fiche,
  required int poids_unitaire,
  required int montant_achat,
  required int prix_fg_kg,
  required int distance_origine_marche,
  required int montant_transport,
  required int app_mobile,
  required int quantite_collecte,
  required int client_principal,
  required int fournisseur_principal,
  required int niveau_approvisionement,
  required int statut,
  required String localite_origine,
  required String etat_route,
  required String observation,
  required DateTime date_enregistrement,  // Utilisation de DateTime
  required String id_personnel,
}) async {
  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer
  String formattedDate = DateFormat('yyyy-MM-dd').format(date_enregistrement);
  // String formattedDate = DateTime.parse(json['date_enquete']);


  var addPrixMarcheGrossiste = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'poids_unitaire': poids_unitaire,
    'id_fiche': id_fiche,
    'montant_achat': montant_achat,
    'prix_fg_kg': prix_fg_kg,
    'localite_origine': localite_origine,
    'distance_origine_marche': distance_origine_marche,
    'montant_transport': montant_transport,
    'etat_route': etat_route,
    'statut': statut,
    'quantite_collecte': quantite_collecte,
    'client_principal': client_principal,
    'fournisseur_principal': fournisseur_principal,
    'niveau_approvisionement': niveau_approvisionement,
    'app_mobile': app_mobile,
    'date_enregistrement': formattedDate,  // Envoyer la date formatée
  });

  try {
    final response = await http.post(
      Uri.parse("$apiUrl/$baseUrl/create/"),
      headers: {'Content-Type': 'application/json'},
      body: addPrixMarcheGrossiste,
    );

    print('Request Body: ${addPrixMarcheGrossiste.toString()}');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet envoyé avec succès");
      Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Erreur: ${response.body}");
    }
  } catch (e) {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
    print('Erreur lors de l\'ajout: $e');
  }
  }

  

  Future<void> addPrixMarcheConsommation({
  required int enquete,
  required String produit,
  required int unite,
  required int id_fiche,
  required int poids_unitaire,
  required int montant_achat,
  required int prix_fg_kg,
  required int distance_origine_marche,
  required int montant_transport,
  required int app_mobile,
  required int quantite_collecte,
  required int client_principal,
  required int fournisseur_principal,
  required int niveau_approvisionement,
  required int statut,
  required String localite_origine,
  required String etat_route,
  required String observation,
  required DateTime date_enregistrement,  // Utilisation de DateTime
  required String id_personnel,
}) async {
  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer
  String formattedDate = DateFormat('yyyy-MM-dd').format(date_enregistrement);
  // String formattedDate = DateTime.parse(json['date_enquete']);


  var addPrixMarcheConsommation = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'poids_unitaire': poids_unitaire,
    'id_fiche': id_fiche,
    'montant_achat': montant_achat,
    'prix_fg_kg': prix_fg_kg,
    'localite_origine': localite_origine,
    'distance_origine_marche': distance_origine_marche,
    'montant_transport': montant_transport,
    'etat_route': etat_route,
    'statut': statut,
    'quantite_collecte': quantite_collecte,
    'client_principal': client_principal,
    'fournisseur_principal': fournisseur_principal,
    'niveau_approvisionement': niveau_approvisionement,
    'app_mobile': app_mobile,
    'date_enregistrement': formattedDate,  // Envoyer la date formatée
  });

  try {
    final response = await http.post(
      Uri.parse("$apiUrl/$baseUrl/create/"),
      headers: {'Content-Type': 'application/json'},
      body: addPrixMarcheConsommation,
    );

    print('Request Body: ${addPrixMarcheConsommation.toString()}');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet envoyé avec succès");
      Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Erreur: ${response.body}");
    }
  } catch (e) {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
    print('Erreur lors de l\'ajout: $e');
  }
  }


  Future<void> updatePrixMarcheCollecte({
  required int enquete,
  required String produit,
  required int unite,
  required int id_fiche,
  required int poids_unitaire,
  required int montant_achat,
  required int prix_fg_kg,
  required int distance_origine_marche,
  required int montant_transport,
  required int app_mobile,
  required int quantite_collecte,
  required int client_principal,
  required int fournisseur_principal,
  required int niveau_approvisionement,
  required int statut,
  required String localite_origine,
  // required String modifier_le,
  // required String modifier_par,
  required String etat_route,
  required String observation,
  // required DateTime date_enregistrement,  // Utilisation de DateTime
  required String id_personnel,
}) async {
  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer
  DateTime date = DateTime.now();
  String formattedDateModif = DateFormat('yyyy-MM-dd').format(date);

  // String formattedDate = DateFormat('yyyy-MM-dd').format(date_enregistrement);
  // String formattedDate = DateTime.parse(json['date_enquete']);


  var updatePrixMarcheCollecte = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'poids_unitaire': poids_unitaire,
    'id_fiche': id_fiche,
    'montant_achat': montant_achat,
    'prix_fg_kg': prix_fg_kg,
    // 'modifier_le': formattedDateModif,
    // 'modifier_par': modifier_par,
    'localite_origine': localite_origine,
    'distance_origine_marche': distance_origine_marche,
    'montant_transport': montant_transport,
    'etat_route': etat_route,
    'statut': statut,
    'quantite_collecte': quantite_collecte,
    'client_principal': client_principal,
    'fournisseur_principal': fournisseur_principal,
    'niveau_approvisionement': niveau_approvisionement,
    'app_mobile': app_mobile,
    // 'date_enregistrement': formattedDate,  // Envoyer la date formatée
  });

  try {
    final response = await http.put(
      Uri.parse("$apiUrl/$baseUrl/update/$id_fiche"),
      headers: {'Content-Type': 'application/json'},
      body: updatePrixMarcheCollecte,
    );

    print('Request Body: ${updatePrixMarcheCollecte.toString()}');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet envoyé avec succès");
      Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Erreur: ${response.body}");
    }
  } catch (e) {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
    print('Erreur lors de l\'ajout: $e');
  }
  }


  Future<void> updatePrixMarcheConsommation({
  required int enquete,
  required String produit,
  required int unite,
  required int id_fiche,
  required int poids_unitaire,
  required int montant_achat,
  required int prix_fg_kg,
  required int distance_origine_marche,
  required int montant_transport,
  required int app_mobile,
  required int quantite_collecte,
  required int client_principal,
  required int fournisseur_principal,
  required int niveau_approvisionement,
  required int statut,
  required String localite_origine,
  required String modifier_le,
  required String modifier_par,
  required String etat_route,
  required String observation,
  required DateTime date_enregistrement,  // Utilisation de DateTime
  required String id_personnel,
}) async {
  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer
  String formattedDate = DateFormat('yyyy-MM-dd').format(date_enregistrement);
  // String formattedDate = DateTime.parse(json['date_enquete']);


  var updatePrixMarcheConsommation = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'poids_unitaire': poids_unitaire,
    'id_fiche': id_fiche,
    'montant_achat': montant_achat,
    'prix_fg_kg': prix_fg_kg,
    'modifier_le': modifier_le,
    'modifier_par': modifier_par,
    'localite_origine': localite_origine,
    'distance_origine_marche': distance_origine_marche,
    'montant_transport': montant_transport,
    'etat_route': etat_route,
    'statut': statut,
    'quantite_collecte': quantite_collecte,
    'client_principal': client_principal,
    'fournisseur_principal': fournisseur_principal,
    'niveau_approvisionement': niveau_approvisionement,
    'app_mobile': app_mobile,
    'date_enregistrement': formattedDate,  // Envoyer la date formatée
  });

  try {
    final response = await http.put(
      Uri.parse("$apiUrl/$baseUrl/update/$id_fiche"),
      headers: {'Content-Type': 'application/json'},
      body: updatePrixMarcheConsommation,
    );

    print('Request Body: ${updatePrixMarcheConsommation.toString()}');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet envoyé avec succès");
      Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Erreur: ${response.body}");
    }
  } catch (e) {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
    print('Erreur lors de l\'ajout: $e');
  }
  }


  Future<void> updatePrixMarcheGrossiste({
  required int enquete,
  required String produit,
  required int unite,
  required int id_fiche,
  required int poids_unitaire,
  required int montant_achat,
  required int prix_fg_kg,
  required int distance_origine_marche,
  required int montant_transport,
  required int app_mobile,
  required int quantite_collecte,
  required int client_principal,
  required int fournisseur_principal,
  required int niveau_approvisionement,
  required int statut,
  required String localite_origine,
  required String modifier_le,
  required String modifier_par,
  required String etat_route,
  required String observation,
  required DateTime date_enregistrement,  // Utilisation de DateTime
  required String id_personnel,
}) async {
  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer
  String formattedDate = DateFormat('yyyy-MM-dd').format(date_enregistrement);
  // String formattedDate = DateTime.parse(json['date_enquete']);


  var updatePrixMarcheGrossiste = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'poids_unitaire': poids_unitaire,
    'id_fiche': id_fiche,
    'montant_achat': montant_achat,
    'prix_fg_kg': prix_fg_kg,
    'modifier_le': modifier_le,
    'modifier_par': modifier_par,
    'localite_origine': localite_origine,
    'distance_origine_marche': distance_origine_marche,
    'montant_transport': montant_transport,
    'etat_route': etat_route,
    'statut': statut,
    'quantite_collecte': quantite_collecte,
    'client_principal': client_principal,
    'fournisseur_principal': fournisseur_principal,
    'niveau_approvisionement': niveau_approvisionement,
    'app_mobile': app_mobile,
    'date_enregistrement': formattedDate,  // Envoyer la date formatée
  });

  try {
    final response = await http.put(
      Uri.parse("$apiUrl/$baseUrl/update/$id_fiche"),
      headers: {'Content-Type': 'application/json'},
      body: updatePrixMarcheGrossiste,
    );

    print('Request Body: ${updatePrixMarcheGrossiste.toString()}');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet envoyé avec succès");
      Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Erreur: ${response.body}");
    }
  } catch (e) {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
    print('Erreur lors de l\'ajout: $e');
  }
  }


    Future<void> deletePrixMarcheCollecte(int id) async {
    try {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrl1/delete/$id/'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      Snack.success(titre: "Succès", message: "Supprimer avec succès");
      applyChange();
    } else {
      // Vérifiez si le corps de la réponse n'est pas vide avant de le décoder
      if (response.body.isNotEmpty) {
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception(decodedResponse["message"]);
      } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
        print("Échec de la requête lors de la suppression de prix marche collecte avec le code d'état: ${response.statusCode}");
        throw Exception("Erreur lors de la suppression, aucune réponse du serveur.");
      }
    }
  } catch (e) {
    print("Erreur : $e");
    throw Exception("Une erreur s'est produite lors de la suppression.");
  }
}


    Future<void> deletePrixMarcheGrossiste(int id) async {
    try {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrlG/delete/$id/'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      Snack.success(titre: "Succès", message: "Supprimer avec succès");
      applyChange();
    } else {
      // Vérifiez si le corps de la réponse n'est pas vide avant de le décoder
      if (response.body.isNotEmpty) {
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception(decodedResponse["message"]);
      } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
        print("Échec de la requête lors de la suppression de prix marche grossiste avec le code d'état: ${response.statusCode}");
        throw Exception("Erreur lors de la suppression, aucune réponse du serveur.");
      }
    }
  } catch (e) {
    print("Erreur : $e");
    throw Exception("Une erreur s'est produite lors de la suppression.");
  }
}


    Future<void> deletePrixMarcheConsommation(int id) async {
    try {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrlC/delete/$id/'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      Snack.success(titre: "Succès", message: "Supprimer avec succès");
      applyChange();
    } else {
      // Vérifiez si le corps de la réponse n'est pas vide avant de le décoder
      if (response.body.isNotEmpty) {
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        throw Exception(decodedResponse["message"]);
      } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
        print("Échec de la requête lors de la suppression de prix marche consommation avec le code d'état: ${response.statusCode}");
        throw Exception("Erreur lors de la suppression, aucune réponse du serveur.");
      }
    }
  } catch (e) {
    print("Erreur : $e");
    throw Exception("Une erreur s'est produite lors de la suppression.");
  }
}



   void applyChange() {
    notifyListeners();
  }

}