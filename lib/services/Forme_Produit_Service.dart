
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/models/Forme_Produit.dart';
import 'package:simro/screens/home.dart';

class CategorieProduitService extends ChangeNotifier {
  final String baseUrl = "all-forme-produits/";

    List<FormeProduit> formeProduitList = [];


   Future<List<FormeProduit>> fetchFormeProduit() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      formeProduitList =
          body.map((item) => FormeProduit.fromMap(item)).toList();
      print(response.body);
      return formeProduitList;
    } else {
      
      print('Échec de la requête lors de la recuperation des formes produit avec le code d\'état: ${response.statusCode}');
      return formeProduitList = [];
    }
  }



  void applyChange() {
    notifyListeners();
  }
  

}
