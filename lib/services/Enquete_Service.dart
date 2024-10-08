
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Assure-toi d'importer intl
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/models/Enquete.dart';
import 'package:simro/models/Enquete_Collecte.dart';
import 'package:simro/models/Enquete_Grossiste.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/widgets/Snackbar.dart';

class EnqueteService extends ChangeNotifier {
  final String baseUrl = "enquete-collecte";
  final String baseUrlG = "enquete-grossiste";
  final String baseUrlC = "enquete";

    List<Enquete> enqueteList = [];
    List<EnqueteCollecte> enqueteCollecteList = [];
    List<EnqueteGrossiste> enqueteGrossisteList = [];


   Future<List<EnqueteCollecte>> fetchEnqueteCollecte() async {
    final response = await http.get(Uri.parse("$apiUrl/all-enquete-collecte"));

    if (response.statusCode == 200 || response.statusCode == 201) {
     final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      enqueteCollecteList =
          body.map((item) => EnqueteCollecte.fromMap(item)).toList();
      print(response.body);
      return enqueteCollecteList;
    } else {
      
      print('Échec de la requête lors de la recuperation des enquetes collecter avec le code d\'état: ${response.statusCode}');
      return enqueteCollecteList = [];
    }
  }
  
   Future<List<Enquete>> fetchEnquete() async {
    final response = await http.get(Uri.parse("$apiUrl/all-enquete/"));

    if (response.statusCode == 200 || response.statusCode == 201) {
     final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      enqueteList =
          body.map((item) => Enquete.fromMap(item)).toList();
      print(response.body);
      return enqueteList;
    } else {
      
      print('Échec de la requête lors de la recuperation des enquetes collecter avec le code d\'état: ${response.statusCode}');
      return enqueteList = [];
    }
  }

   Future<List<EnqueteGrossiste>> fetchEnqueteGrossiste() async {
    final response = await http.get(Uri.parse("$apiUrl/all-enquete-grossiste"));

    if (response.statusCode == 200 || response.statusCode == 201) {
     final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      enqueteGrossisteList =
          body.map((item) => EnqueteGrossiste.fromMap(item)).toList();
      print(response.body);
      return enqueteGrossisteList;
    } else {
      
      print('Échec de la requête lors de la recuperation des enquetes collecter avec le code d\'état: ${response.statusCode}');
      return enqueteGrossisteList = [];
    }
  }


 Future<void> addEnqueteCollecte({
  required String num_fiche,
  required String marche,
  required String collecteur,
  required DateTime date_enquete,  // Utilisation de DateTime
  required String id_personnel,
}) async {
  // Reformater la date en 'yyyy-MM-dd' avant de l'envoyer
  String formattedDate = DateFormat('yyyy-MM-dd').format(date_enquete);
  // String formattedDate = DateTime.parse(json['date_enquete']);


  var addEnqueteCollecte = jsonEncode({
    'id_personnel': id_personnel,
    'num_fiche': num_fiche,
    'collecteur': collecteur,
    'marche': marche,
    'date_enquete': formattedDate,  // Envoyer la date formatée
  });

  try {
    final response = await http.post(
      Uri.parse("$apiUrl/$baseUrl/create/"),
      headers: {'Content-Type': 'application/json'},
      body: addEnqueteCollecte,
    );

    print('Request Body: ${addEnqueteCollecte.toString()}');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Objet enquete collecte envoyé avec succès");
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



  Future<void> addEnquete({
      required String observation,
      required String statut,
      required String marche,
      required int collecteur,
      required DateTime date_enquete,
      }) async {
          String formattedDate = DateFormat('yyyy-MM-dd').format(date_enquete);

    var addEnquete = jsonEncode({
      'id_enquete': null,
      'observation': observation,
      'statut': statut,
      'collecteur': collecteur,
      'marche': marche,
      'date_enquete': formattedDate,
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrlC/create/"),
        headers: {'Content-Type': 'application/json'}, body: addEnquete);
    print(addEnquete.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
            Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Une erreur s'est produite lors de l'ajout denquete consommation' : ${response.statusCode}");
    }
  }

  Future<void> addEnqueteGrossiste({
      required String id_personnel,
      required String num_fiche,
      required String marche,
      required String collecteur,
      required DateTime date_enquete,
      }) async {
       String formattedDate = DateFormat('yyyy-MM-dd').format(date_enquete);

    var addEnqueteGrossiste = jsonEncode({
    'id_personnel': id_personnel,
    'num_fiche': num_fiche,
    'collecteur': collecteur,
    'marche': marche,
    'date_enquete': formattedDate, 
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrlG/create/"),
        headers: {'Content-Type': 'application/json'}, body: addEnqueteGrossiste);
    print(addEnqueteGrossiste.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
            Snack.success(titre: "Succès", message: "Ajouté avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Une erreur s'est produite lors de l'ajout denquete collecte' : ${response.statusCode}");
    }
  }

  Future<void> updateEnqueteCollecte({
  required int id_enquete,
  required String num_fiche,
  required String marche,
  required String collecteur,
  required DateTime date_enquete,
}) async {
  // Formatter la date correctement
  String formattedDate = DateFormat('yyyy-MM-dd').format(date_enquete);

  // Créer le JSON pour l'update
  var updateEnqueteCollecte = jsonEncode({
    'id_enquete': id_enquete,
    'num_fiche': num_fiche,
    'collecteur': collecteur,
    'marche': marche,
    'date_enquete': formattedDate,
  });

  // Vérifier le JSON avant de l'envoyer
  print(updateEnqueteCollecte.toString());

  // Mettre à jour l'URL sans accolades autour de l'id_enquete
  final response = await http.put(Uri.parse("$apiUrl/$baseUrl/update/$id_enquete/"),
      headers: {'Content-Type': 'application/json'}, body: updateEnqueteCollecte);

  // Vérifier le statut de la réponse
  if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
    print("update enquete collecte " + response.body);
      Snack.success(titre: "Succès", message: "Modifier avec succès");
  } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
    throw Exception("Une erreur s'est produite lors de la modification d'enquete collecte' : ${response.statusCode}");
  }
}


  Future<void> updateEnquete({
      required int id_enquete,
      required String observation,
      required String statut,
      required String marche,
      required int collecteur,
      required DateTime date_enquete,
      }) async {

      String formattedDate = DateFormat('yyyy-MM-dd').format(date_enquete);

    var updateEnqueteGrossiste = jsonEncode({
      'id_enquete': id_enquete,
      'observation': observation,
      'statut': statut,
      'collecteur': collecteur,
      'marche': marche,
      'date_enquete': formattedDate,
    });

    final response = await http.put(Uri.parse("$apiUrl/$baseUrlC/update/$id_enquete/"),
        headers: {'Content-Type': 'application/json'}, body: updateEnqueteGrossiste);
    print("ipdate " +updateEnqueteGrossiste.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
      Snack.success(titre: "Succès", message: "Modifier avec succès");
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Une erreur s'est produite lors de la modification d'enquete grossiste' : ${response.statusCode}");
    }
  }

  Future<void> updateEnqueteGrossiste({
      required int id_enquete,
      required String num_fiche,
      required String marche,
      required String collecteur,
      required DateTime date_enquete,
      }) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date_enquete);
    var updateEnqueteConsommation = jsonEncode({
      'id_enquete': id_enquete,
      'num_fiche': num_fiche,
      'collecteur': collecteur,
      'marche': marche,
      'date_enquete': formattedDate,
    });

    final response = await http.put(Uri.parse("$apiUrl/$baseUrlG/update/$id_enquete/"),
        headers: {'Content-Type': 'application/json'}, body: updateEnqueteConsommation);
    print(updateEnqueteConsommation.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      Snack.success(titre: "Succès", message: "Modifier avec succès");
      print(response.body);
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      throw Exception("Une erreur s'est produite lors de la modification d'enquete consommation' : ${response.statusCode}");
    }
  }


   Future<void> deleteEnqueteCollecte(int id) async {
    try {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrl/delete/$id/'));

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
        print("Échec de la requête lors de la suppression d'enquete collecte avec le code d'état: ${response.statusCode}");
        throw Exception("Erreur lors de la suppression, aucune réponse du serveur.");
      }
    }
  } catch (e) {
    print("Erreur : $e");
    throw Exception("Une erreur s'est produite lors de la suppression.");
  }
}

   
   Future deleteEnqueteGrossiste(int id_enquete) async {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrlG/delete/$id_enquete/'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      Snack.success(titre: "Succès", message: "Supprimer avec succès");
      applyChange();
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      print("Échec de la requête lors de la suppression d'enquete grossiste avec le code d\'état: ${response.statusCode}");
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

   Future deleteEnquete(int id_enquete) async {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrlC/delete/$id_enquete/'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      Snack.success(titre: "Succès", message: "Supprimer avec succès");
      applyChange();
    } else {
      Snack.error(titre: "Erreur", message: "une erreur s'est produite veuillez réessayer plus tard");
      print("Échec de la requête lors de la suppression d'enquete consommation avec le code d\'état: ${response.statusCode}");
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

    void applyChange() {
    notifyListeners();
  }

}

