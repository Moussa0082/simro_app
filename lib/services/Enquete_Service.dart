
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/models/Enquete_Collecte.dart';
import 'package:simro/models/Enquete_Grossiste.dart';
import 'package:simro/screens/home.dart';

class EnqueteService extends ChangeNotifier {
  final String baseUrl = "enquete-collecte";
  final String baseUrlG = "enquete-grossiste";
  final String baseUrlC = "enquete-consommation";

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
      required String date_enquete,
      }) async {
    var addEnqueteCollecte = jsonEncode({
      'id_enquete': null,
      'num_fiche': num_fiche,
      'collecteur': collecteur,
      'date_enquete': date_enquete,
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrl/create"),
        headers: {'Content-Type': 'application/json'}, body: addEnqueteCollecte);
    print(addEnqueteCollecte.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
    } else {
      throw Exception("Une erreur s'est produite lors de l'ajout denquete collecte' : ${response.statusCode}");
    }
  }

  Future<void> addEnqueteConsommation({
      required String num_fiche,
      required String marche,
      required String collecteur,
      required String date_enquete,
      }) async {
    var addEnqueteConsommation = jsonEncode({
      'id_enquete': null,
      'num_fiche': num_fiche,
      'collecteur': collecteur,
      'date_enquete': date_enquete,
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrlC/create"),
        headers: {'Content-Type': 'application/json'}, body: addEnqueteConsommation);
    print(addEnqueteConsommation.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
    } else {
      throw Exception("Une erreur s'est produite lors de l'ajout denquete consommation' : ${response.statusCode}");
    }
  }

  Future<void> addEnqueteGrossiste({
      required String num_fiche,
      required String marche,
      required String collecteur,
      required String date_enquete,
      }) async {
    var addEnqueteGrossiste = jsonEncode({
      'id_enquete': null,
      'num_fiche': num_fiche,
      'collecteur': collecteur,
      'date_enquete': date_enquete,
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrlG/create"),
        headers: {'Content-Type': 'application/json'}, body: addEnqueteGrossiste);
    print(addEnqueteGrossiste.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
    } else {
      throw Exception("Une erreur s'est produite lors de l'ajout denquete collecte' : ${response.statusCode}");
    }
  }

  Future<void> updateEnqueteCollecte({
      required int id_enquete,
      required String num_fiche,
      required String marche,
      required String collecteur,
      required String date_enquete,
      }) async {
    var updateEnqueteCollecte = jsonEncode({
      'id_enquete': id_enquete,
      'num_fiche': num_fiche,
      'collecteur': collecteur,
      'date_enquete': date_enquete,
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrl/update/{$id_enquete}"),
        headers: {'Content-Type': 'application/json'}, body: updateEnqueteCollecte);
    print(updateEnqueteCollecte.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
    } else {
      throw Exception("Une erreur s'est produite lors de la modification d'enquete collecte' : ${response.statusCode}");
    }
  }

  Future<void> updateEnqueteGrossiste({
      required int id_enquete,
      required String num_fiche,
      required String marche,
      required String collecteur,
      required String date_enquete,
      }) async {
    var updateEnqueteGrossiste = jsonEncode({
      'id_enquete': id_enquete,
      'num_fiche': num_fiche,
      'collecteur': collecteur,
      'date_enquete': date_enquete,
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrlG/update/{$id_enquete}"),
        headers: {'Content-Type': 'application/json'}, body: updateEnqueteGrossiste);
    print(updateEnqueteGrossiste.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
    } else {
      throw Exception("Une erreur s'est produite lors de la modification d'enquete grossiste' : ${response.statusCode}");
    }
  }

  Future<void> updateEnqueteConsommation({
      required int id_enquete,
      required String num_fiche,
      required String marche,
      required String collecteur,
      required String date_enquete,
      }) async {
    var updateEnqueteConsommation = jsonEncode({
      'id_enquete': id_enquete,
      'num_fiche': num_fiche,
      'collecteur': collecteur,
      'date_enquete': date_enquete,
    });

    final response = await http.post(Uri.parse("$apiUrl/$baseUrlC/update/{$id_enquete}"),
        headers: {'Content-Type': 'application/json'}, body: updateEnqueteConsommation);
    print(updateEnqueteConsommation.toString());
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print(response.body);
    } else {
      throw Exception("Une erreur s'est produite lors de la modification d'enquete consommation' : ${response.statusCode}");
    }
  }


   Future deleteEnqueteCollecte(String id_enquete) async {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrl/delete/$id_enquete'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      applyChange();
    } else {
      print("Échec de la requête lors de la suppression d'enquete collecte avec le code d\'état: ${response.statusCode}");
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
   Future deleteEnqueteGrossiste(String id_enquete) async {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrlG/delete/$id_enquete'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      applyChange();
    } else {
      print("Échec de la requête lors de la suppression d'enquete grossiste avec le code d\'état: ${response.statusCode}");
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
   Future deleteEnqueteConsommation(String id_enquete) async {
    final response = await http.delete(Uri.parse('$apiUrl/$baseUrlC/delete/$id_enquete'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      applyChange();
    } else {
      print("Échec de la requête lors de la suppression d'enquete consommation avec le code d\'état: ${response.statusCode}");
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

    void applyChange() {
    notifyListeners();
  }

}

