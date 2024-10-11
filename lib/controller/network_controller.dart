
//  import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NetworkController extends GetxController{

//    final Connectivity _connectivity = Connectivity();

//    @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnexionStatus);
//   }

//   Future<void> _updateConnexionStatus(List<ConnectivityResult> connectivityResult) async { 
//     connectivityResult = await (Connectivity().checkConnectivity());  
//     if (connectivityResult.contains(ConnectivityResult.none)) {
//       print('No internet connection');
//       //  WidgetsBinding.instance.addPostFrameCallback((_) {
//       //   BuildContext context = BuildContext;
//       //     ScaffoldMessenger.of(context).showSnackBar(
//       //       SnackBar(
//       //         content: Text("Vous êtes hors connexion"),
//       //         backgroundColor: Colors.red,
//       //         duration: Duration(days: 1), // Garder le SnackBar affiché indéfiniment
//       //       ),
//       //     );
//       //   });
//     }else if (connectivityResult.contains(ConnectivityResult.wifi)) {
//   // Wi-fi is available.
//    print("wifi");
//   // Note for Android:
//   // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
// }
//     else{
//       print(' internet connection');
//     }
//   }

// }

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:simro/widgets/Snackbar.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
   bool isConnectedToInternet = true;

  StreamSubscription? _internetConnectionStreamSubscription;



 @override
void onInit() {
  super.onInit();
  InternetConnection().onStatusChange.listen((event) {
    BuildContext? context = Get.context;
    switch (event) {
      case InternetStatus.connected:
        isConnectedToInternet = true;
        print("connecté");
        
        // Fermer tous les SnackBars existants si l'utilisateur se reconnecte
        if (context != null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Vous êtes connecté à internet'),
              duration: Duration(days: 1), // Garde le SnackBar affiché
              backgroundColor: Colors.green,
              // action: SnackBarAction(
              //   label: 'OK',
              //   onPressed: () {
              //     Get.back();
              //     // Optionnel : ajouter une action pour que l'utilisateur puisse le masquer manuellement
              //   },
              // ),
            ),
          );
        }
        break;

      case InternetStatus.disconnected:
        isConnectedToInternet = false;
        print("déconnecté");
        
        // Si l'utilisateur n'a pas de connexion, afficher un SnackBar permanent
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Vous êtes hors connexion'),
              duration: Duration(days: 1), // Garde le SnackBar affiché
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  Get.back();
                  // Optionnel : ajouter une action pour que l'utilisateur puisse le masquer manuellement
                },
              ),
            ),
          );
        }
        break;

      default:
        isConnectedToInternet = false;
        print("déconnecté");
        break;
    }
  });

  _updateConnectivityStatus();
}


    @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _updateConnectivityStatus() async {


    if (isConnectedToInternet) {
      print(' internet connection');
      // Show SnackBar
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   BuildContext? context = Get.context; // Access context using GetX
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text("Vous êtes hors connexion"),
      //       backgroundColor: Colors.red,
      //       duration: const Duration(seconds: 4), // Set a reasonable duration
      //     ),
      //   );
      // });
    } else {
      print('Not Connected');
    }
  }
}