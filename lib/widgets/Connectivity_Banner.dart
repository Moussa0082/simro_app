import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simro/controller/network_controller.dart';
import 'package:simro/provider/Connectivity_Prodvider.dart';
import 'package:simro/services/Connectivity_Service.dart';

class ConnectivityBanner extends StatelessWidget {
  // Widget pour afficher la bannière de connectivité
  @override
  // Widget build(BuildContext context) {

  //   return Positioned(
  //     top: 0,
  //     left: 0,
  //     right: 0,
  //     child: Container(
  //       color: connectivityService.isConnected ? Colors.green : Colors.red,
  //       padding: const EdgeInsets.all(8),
  //       child: Text(
  //         connectivityService.isConnected ? "Connecté" : "Hors connexion",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

 @override
  Widget build(BuildContext context) {
     final st =    Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;


   // Vérifiez si l'utilisateur est hors ligne
    if (st == false) {
      // Afficher le SnackBar uniquement si ce n'est pas déjà affiché
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Vous êtes hors connexion"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5), // Garder le SnackBar affiché indéfiniment
            ),
          );
        });
      
      print("hors ligne");
      return SizedBox.shrink(); // Ne rien afficher si hors ligne
    } else {
      // Si l'utilisateur se reconnecte, afficher un message de reconnexion
      // if (_isSnackbarShown) {
      print("en ligne");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Vous êtes connecté"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
            ),
          );
        });
      // }
      return SizedBox.shrink(); // Ne rien afficher si connecté
    }
  }
  
}  

