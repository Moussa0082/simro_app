
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
      switch (event) {
        case InternetStatus.connected:
            isConnectedToInternet = true;
            print(event);
            print("connecté");
              Snack.success(titre:"Alerte", message:"Vous êtes connecté à internet");
          break;
        case InternetStatus.disconnected:
              Snack.error(titre:"Alerte", message:"Vous êtes hors connexion");
            print("deconnecté");
            print(event);
            isConnectedToInternet = false;
          break;
        default:
            print("deconnecté");
          
            isConnectedToInternet = false;
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