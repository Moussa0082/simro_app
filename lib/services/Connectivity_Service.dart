import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simro/widgets/Snackbar.dart';

class ConnectivityService extends ChangeNotifier{
  final _connectivity = Connectivity();
  bool? _isConnected ;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  void init(BuildContext context) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Vérifie s'il y a au moins une connexion disponible
      // _isConnected = results.any((result) => result != ConnectivityResult.none);
           if (results.contains(ConnectivityResult.none)) {
      _isConnected = results.any((result) => result != ConnectivityResult.none);
   print("hors connexion ");
  // No available network types
      _isConnected = false;
}else{
      _isConnected = true;
   print(" connexion établie");

}

      if (!_isConnected!) {
        showOfflineMessage(context);
      } else {
        showOnlineMessage(context);
      }
    });
  }

  // Afficher un message lorsqu'il est de nouveau connecté
  void showOnlineMessage(BuildContext context) {
    Snack.success(titre: "Alerte", message: "Connexion etablie");
  }

  // Afficher un message lorsqu'il est hors connexion
  void showOfflineMessage(BuildContext context) {
    
    Snack.error(titre: "Alerte", message: "Vous etes hors connexion");
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }

  bool get isConnected => _isConnected!;

   void applyChange() {
    notifyListeners();
  }
  
}
