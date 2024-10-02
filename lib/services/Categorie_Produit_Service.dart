
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/screens/home.dart';

class CategorieProduitService extends ChangeNotifier  {
  final String baseUrl = "all-categorie-produits/";

    List<CategorieProduit> categorieList = [];


   Future<List<CategorieProduit>> fetchCategorie() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl"));

    if (response.statusCode == 200 || response.statusCode == 201) {
     final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      categorieList =
          body.map((item) => CategorieProduit.fromMap(item)).toList();
      print(response.body);
      return categorieList;
    } else {
      
      print('Échec de la requête lors de la recuperation des categories avec le code d\'état: ${response.statusCode}');
      return categorieList = [];
    }
  }

    void applyChange() {
    notifyListeners();
  }
  

}
