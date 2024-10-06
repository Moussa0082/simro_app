
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/widgets/Snackbar.dart';

class EnqueteurService extends ChangeNotifier{
  final String baseUrl = "enqueteur";


  Future<Map<String, dynamic>> loginWithPin(String pin) async {
  final String url = '$apiUrl/$baseUrl/login/';
  print('URL de la requête: $url');

  try {
    // for (int attempt = 0; attempt < 3; attempt++) { // Limiter le nombre de tentatives
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'code': pin}),
      );

      if (response.statusCode == 200) {
      
        return json.decode(response.body);
      } else if (response.statusCode == 307) {
        final redirectUrl = response.headers['location'];
        print('Redirection vers: $redirectUrl');

        final redirectResponse = await http.post(
          Uri.parse(redirectUrl!),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'code': pin}),
        );

        if (redirectResponse.statusCode == 200) {
            
          return json.decode(redirectResponse.body);
        }
      } else {
        // print('Échec de la connexion (tentative $attempt): ${response.body}');
        // Afficher un message d'erreur plus spécifique en fonction du code de statut
        if (response.statusCode == 401) {
          Get.snackbar("Erreur", "Code Pin incorrect", snackPosition: SnackPosition.BOTTOM);
        } else if (response.statusCode == 500) {
          Get.snackbar("Erreur", "Erreur serveur", snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Erreur", "Une erreur s'est produite", snackPosition: SnackPosition.BOTTOM);
        }
      }
    // }

    // Si toutes les tentatives ont échoué
    // Get.snackbar("Erreur", "Trop de tentatives échouées", snackPosition: SnackPosition.BOTTOM);
    return {};
  } catch (e) {
    print('Erreur inattendue: $e');
    Get.snackbar("Erreur", "Une erreur inattendue s'est produite", snackPosition: SnackPosition.BOTTOM);
    return {};
  }
}



   void applyChange() {
    notifyListeners();
  }

  

}
