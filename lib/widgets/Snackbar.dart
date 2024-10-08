import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';

class Snack{

  static success({required String titre,required String message}){
    Get.snackbar(titre, message,  backgroundColor:  vert,duration: Duration(seconds: 5 ) 
    
    // ,icon:Image.asset("assets/images/logo.png")
    // , snackPosition: SnackPosition.BOTTOM
    );
  }

static void error({required String titre, required String message}) {
    // Vérifie si le contexte est valide avant d'afficher le SnackBar
    if (Get.context != null) {
      Get.snackbar(
        titre,
        message,
        backgroundColor: Colors.red,
        // snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 4),
      );
    } else {
      print("Impossible d'afficher le SnackBar, contexte indisponible.");
    }
  }
  static info({required String message}){
    Get.snackbar('Info', message,  duration: Duration(seconds: 5)
    // icon:Image.asset("assets/images/logo.png")
    , snackPosition: SnackPosition.BOTTOM
    );
  }



  
  
}