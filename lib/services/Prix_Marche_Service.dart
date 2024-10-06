import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Produit_Info.dart';
import 'package:http/http.dart' as http;



class PrixMarcheService extends ChangeNotifier{

   String baseUrl = "marche";
   String prixProduitUrl = "liste-prix-moyen-par-produit/";
  
       List<PrixInfo> prixInfoList = [];


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


   void applyChange() {
    notifyListeners();
  }

}