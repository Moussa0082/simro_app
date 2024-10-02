
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/models/Marche.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/screens/home.dart';

class MarcheService extends ChangeNotifier {
  final String baseUrl = "all-marche/";

    List<Marche> marcheList = [];


   Future<List<Marche>> fetchMarche() async {
    final response = await http.get(Uri.parse("$apiUrl/$baseUrl"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final String jsonString = utf8.decode(response.bodyBytes);
              List<dynamic> body = json.decode(jsonString);
      marcheList =
          body.map((item) => Marche.fromMap(item)).toList();
      print(response.body);
      return marcheList;
    } else {
      
      print('Échec de la requête lors de la recuperation des marchés avec le code d\'état: ${response.statusCode}');
      return marcheList = [];
    }
  }


  void applyChange() {
    notifyListeners();
  }

  

}
