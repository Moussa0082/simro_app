
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/screens/home.dart';

class ProduitService extends ChangeNotifier {
  final String baseUrl = "all-produits/";
  final String baseUrlPC = "all-produits-by-categorie";

    List<Produit> produitList = [];


   Future<List<Produit>> fetchProduit() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      produitList =
          body.map((item) => Produit.fromMap(item)).toList();
      print("produit normal fetch" + response.body);
      print("produit normal fetch list" + produitList.toString());
      return produitList;
    } else {
      
      print('Échec de la requête lors de la recuperaion des produits avec le code d\'état: ${response.statusCode}');
      return produitList = [];
    }
  }

   Future<List<Produit>> fetchProduitByCategorie(int id) async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrlPC/$id"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      produitList =
          body.map((item) => Produit.fromMap(item)).toList();
      print("produit par categorie" + response.body);
      print("produit by cat fetch list" + produitList.toString());
      return produitList;
    } else {
      
      print('Échec de la requête lors de la recuperaion des produits avec le code d\'état: ${response.statusCode}');
      return produitList = [];
    }
  }


  void applyChange() {
    notifyListeners();
  }

}
