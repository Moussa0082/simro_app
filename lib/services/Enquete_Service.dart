
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/models/Enquete_Collecte.dart';
import 'package:simro/screens/home.dart';

class EnqueteCollecteService extends ChangeNotifier {
  final String baseUrl = "enquete-collecte";

    List<EnqueteCollecte> enqueteCollecteList = [];


   Future<List<EnqueteCollecte>> fetchEnqueteCollecte() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl/create/"));

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
      throw Exception("Une erreur s'est produite lors de la modification denquete collecte' : ${response.statusCode}");
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

    void applyChange() {
    notifyListeners();
  }

}

