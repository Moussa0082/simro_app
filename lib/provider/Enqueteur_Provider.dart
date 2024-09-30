import 'package:flutter/material.dart';
import 'package:simro/models/Enqueteur.dart';

class EnqueteurProvider with ChangeNotifier {
  Enqueteur? _enqueteur;

  Enqueteur? get enqueteur => _enqueteur;

  void setEnqueteur(Enqueteur enqueteur) {
    _enqueteur = enqueteur;
    notifyListeners(); // Notifie les widgets écoutant les changements
  }
}
