import 'dart:convert';
import 'dart:io';

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
      print("fetch prix info body"+ response.body);
      print("fetch prix info list"+ prixInfoList.toString());
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
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl3/"));

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
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl2/"));

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
  required int montant_transport,
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
    'unite': unite,//
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
      print("Erreur: ${response.statusCode} - $errorMessage");
    }
  } catch (e) {
    Snack.error(titre: "Erreur", message: "Une erreur s'est produite, veuillez réessayer plus tard.");
    print('Erreur lors de l\'ajout: $e');
  }
}


  Future<void> addPrixMarcheGrossiste({
  required int enquete,
  required String produit,
  required int unite_stock,
  required double poids_moyen_unite_stock,
  required double nombre_unite_stock,
  required double poids_stock,
  required double nombre_unite_achat,
  required int unite_achat,
  required double poids_moyen_unite_achat,
  required double poids_total_achat,
  required int app_mobile,
  required int fournisseur_achat,
  required int client_vente,
  required String localite_achat,
  required double nombre_unite_vente,
  required int statut,
  required String localite_vente,
  required double poids_moyen_unite_vente,
  required double poids_total_unite_vente,
  required int unite_vente,
  required double prix_unitaire_vente,  // Utilisation de DateTime
  required String id_personnel,
}) async {


  var addPrixMarcheGrossiste = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'unite_stock': unite_stock,
    'client_vente': client_vente,
    'unite_vente': unite_vente,
    'nombre_unite_stock': nombre_unite_stock,
    'poids_moyen_unite_stock': poids_moyen_unite_stock,
    'poids_stock': poids_stock,
    'unite_achat': unite_achat,
    'nombre_unite_achat': nombre_unite_achat,
    'poids_moyen_unite_achat': poids_moyen_unite_achat,
    'poids_total_achat': poids_total_achat,
    'statut': statut,
    'localite_achat': localite_achat,
    'fournisseur_achat': fournisseur_achat,
    'nombre_unite_vente': nombre_unite_vente,
    'localite_vente': localite_vente,
    'app_mobile': app_mobile,
    'poids_moyen_unite_vente': poids_moyen_unite_vente,  // Envoyer la date formatée
    'poids_total_unite_vente': poids_total_unite_vente,  // Envoyer la date formatée
    'prix_unitaire_vente': prix_unitaire_vente,  // Envoyer la date formatée
    // 'observation': observation, 
  });

  try {
    final response = await http.post(
      Uri.parse("$apiUrl/$baseUrlG/create/"),
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
      print("Erreur: ${response.body}");
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
  required double prix_mesure,
  required double poids_unitaire,
  // required String document,
  required double prix_kg_litre,
  required int app_mobile,
  required int niveau_approvisionement,
  required int statut,
  // required String observation,
  required String id_personnel,
}) async {

  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer


  var addPrixMarcheConsommation = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'poids_unitaire': poids_unitaire,
    'prix_kg_litre': prix_kg_litre,
    'statut': statut,
    'prix_mesure': prix_mesure,
    'unite': unite,
    // 'document': document,
    // 'observation': observation,
    'niveau_approvisionement': niveau_approvisionement,
    'app_mobile': app_mobile,
  });

  try {
    final response = await http.post(
      Uri.parse("$apiUrl/$baseUrlC/create/"),
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
      print("Erreur: ${response.body}");
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
  required double poids_unitaire,
  required double montant_achat,
  required double prix_fg_kg,
  required double distance_origine_marche,
  required int montant_transport,
  required int app_mobile,
  required double quantite_collecte,
  required int client_principal,
  required int fournisseur_principal,
  required int niveau_approvisionement,
  required int statut,
  required String localite_origine,
  required String modifier_par,
  required String etat_route,
  required String id_personnel,
}) async {
  DateTime date = DateTime.now();

  var updatePrixMarcheCollecte = jsonEncode({
    'id_personnel': id_personnel,
    'enquete': enquete,
    'produit': produit,
    'unite': unite,
    'poids_unitaire': poids_unitaire,
    'modifier_par': modifier_par,
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
  });

  try {
    final response = await http.put(
      Uri.parse("$apiUrl/$baseUrl1/update/$id_fiche/"),
      headers: {'Content-Type': 'application/json'},
      body: updatePrixMarcheCollecte,
    );

    print('Request Body: ${updatePrixMarcheCollecte.toString()}');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    // Gérer les codes de statut HTTP
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet envoyé avec succès");
      Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else if (response.statusCode == 400) {
      Snack.error(titre: "Erreur", message: "Requête invalide . Vérifiez les données envoyées.");
      print("Erreur 400: ${response.body}");
    } else if (response.statusCode == 401) {
      Snack.error(titre: "Erreur", message: "Non autorisé . Vous devez être authentifié.");
      print("Erreur 401: ${response.body}");
    } else if (response.statusCode == 404) {
      Snack.error(titre: "Erreur", message: "Ressource non trouvée .");
      print("Erreur 404: ${response.body}");
    } else if (response.statusCode == 500) {
      Snack.error(titre: "Erreur", message: "Erreur . Réessayez plus tard.");
      print("Erreur 500: ${response.body}");
    } else {
      // Snack.error(titre: "Erreur", message: "Erreur inattendue. Code: ${response.statusCode}");
      Snack.error(titre: "Erreur", message: "Erreur . Réessayez plus tard.");
      print("Erreur inattendue: ${response.body}");
    }
  } catch (e) {
    // Gestion des erreurs réseau ou de parsing JSON
    if (e is SocketException) {
      Snack.error(titre: "Erreur", message: "Pas de connexion Internet. Vérifiez votre réseau.");
      print('Erreur réseau: $e');
    } else if (e is FormatException) {
      // Snack.error(titre: "Erreur", message: "Erreur de format des données reçues.");
      print('Erreur de format: $e');
    } else {
      Snack.error(titre: "Erreur", message: "Une erreur inattendue s'est produite.");
      print('Erreur lors de l\'ajout: $e');
    }
  }
}


  Future<void> updatePrixMarcheConsommation({
    required int enquete,
  required String produit,
  required int unite,
  required double prix_mesure,
  required double poids_unitaire,
  // required String document,
  required double prix_kg_litre,
  required int app_mobile,
  required int niveau_approvisionement,
  required int statut,
  // required String observation,
  required String id_personnel,
  required int id_fiche,
}) async {
  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer


  var updatePrixMarcheConsommation = jsonEncode({
    'id_personnel': id_personnel,
    'id_fiche': id_fiche,
    'enquete': enquete,
    'produit': produit,
    'poids_unitaire': poids_unitaire,
    'unite': unite,
    'prix_kg_litre': prix_kg_litre,
    'statut': statut,
    'prix_mesure': prix_mesure,
    // 'document': document,
    // 'observation': observation,
    'niveau_approvisionement': niveau_approvisionement,
    'app_mobile': app_mobile,  // Envoyer la date formatée
  });

  try {
    final response = await http.put(
      Uri.parse("$apiUrl/$baseUrlC/update/$id_fiche/"),
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
      print("Erreur: ${response.body}");
    }
  } catch (e) {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
    print('Erreur lors de l\'ajout: $e');
  }
  }


  Future<void> updatePrixMarcheGrossiste({  
  required int id_fiche,
    required int enquete,
    required int unite_vente,
    required String localite_vente,
  required String produit,
  required int unite_stock,
  required double poids_moyen_unite_stock,
  required double nombre_unite_stock,
  required double poids_stock,
  required double nombre_unite_achat,
  required int unite_achat,
  required double poids_moyen_unite_achat,
  required double poids_total_achat,
  required int app_mobile,
  required int fournisseur_achat,
  required String localite_achat,
  required double nombre_unite_vente,
  required int statut,
  required double poids_moyen_unite_vente,
  required double poids_total_unite_vente,
  required int client_vente,
  required double prix_unitaire_vente,  // Utilisation de DateTime
  required String id_personnel,
   
}) async {

  var updatePrixMarcheGrossiste = jsonEncode({
    'id_fiche': id_fiche,
    'id_personnel': id_personnel,
    'enquete': enquete,
    'client_vente': client_vente,
    'unite_vente': unite_vente,
    'localite_vente': localite_vente,
    'produit': produit,
    'unite_stock': unite_stock,
    'nombre_unite_stock': nombre_unite_stock,
    'poids_moyen_unite_stock': poids_moyen_unite_stock,
    'poids_stock': poids_stock,
    'unite_achat': unite_achat,
    'nombre_unite_achat': nombre_unite_achat,
    'poids_moyen_unite_achat': poids_moyen_unite_achat,
    'poids_total_achat': poids_total_achat,
    'statut': statut,
    'localite_achat': localite_achat,
    'fournisseur_achat': fournisseur_achat,
    'nombre_unite_vente': nombre_unite_vente,
    'app_mobile': app_mobile,
    'poids_moyen_unite_vente': poids_moyen_unite_vente,  // Envoyer la date formatée
    'poids_total_unite_vente': poids_total_unite_vente,  // Envoyer la date formatée
    'prix_unitaire_vente': prix_unitaire_vente,  // Envoyer la date formatée
    // 'observation': observation, 
      
  });

  try {
    final response = await http.put(
      Uri.parse("$apiUrl/$baseUrlG/update/$id_fiche/"),
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