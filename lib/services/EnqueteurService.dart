
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/home.dart';

class EnqueteurService extends ChangeNotifier{
  final String baseUrl = "enqueteur";


  Future<Map<String, dynamic>> loginWithPin(String pin) async {
  final String url = '$apiUrl/$baseUrl/login/';
  print('URL de la requête: $url');

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({'code': pin}),
  );

  // Gérer le statut de la réponse
    print( "code par url " + pin);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else if (response.statusCode == 307) {
    // Obtenir l'URL de redirection
    final redirectUrl = response.headers['location'];
    print('Redirection vers: $redirectUrl');

    // Effectuer une nouvelle requête vers l'URL de redirection
    final redirectResponse = await http.post(
      Uri.parse(redirectUrl!),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'code': pin}),
    );

    if (redirectResponse.statusCode == 200) {
      return json.decode(redirectResponse.body);
    } else {
      throw Exception('Échec de la connexion: ${redirectResponse.body}, code: ${redirectResponse.statusCode}');
    }
  } else {
    throw Exception('Échec de la connexion: ${response.body}, code: ${response.statusCode}');
  }
  }

   void applyChange() {
    notifyListeners();
  }

  

}
