import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Enqueteur.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/add_prix_marche_collecte.dart';
import 'package:simro/screens/add_product.dart';
import 'package:simro/screens/detail_product.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/screens/login.dart';
import 'package:simro/screens/enquete_consommation.dart';
import 'package:simro/screens/products.dart';
import 'package:simro/screens/profil.dart';
import 'package:simro/screens/public_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
  void initState() {
    super.initState();
   checkEnqueteurSession();
  }

   void checkEnqueteurSession() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final enqueteurJson = prefs.getString('enqueteur');

  if (token != null && enqueteurJson != null) {
    // Convertir le JSON en objet Enqueteur
    final enqueteurMap = json.decode(enqueteurJson);
    final enqueteur = Enqueteur.fromJson(enqueteurMap);

    // Mettre à jour le Provider avec l'objet Enqueteur restauré
    EnqueteurProvider enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);
    enqueteurProvider.setEnqueteur(enqueteur);

    // Rediriger vers la HomeScreen
     Timer(
        const Duration(seconds: 3),
        () => Get.offAll( const HomeScreen(), duration: const Duration(seconds: 1), transition: Transition.rightToLeftWithFade),
      );
  } else {
    // Rediriger vers la LoginScreen si aucune session n'existe
     Timer(
        const Duration(seconds: 3),
     () => Get.offAll( const PublicHomeScreen(), duration: const Duration(seconds: 1), transition: Transition.rightToLeftWithFade),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const   Text("Bienvenue sur SIMRO", style: TextStyle(color: vertFort,fontSize: 30, fontWeight: FontWeight.bold)),
            const   SizedBox(height: 25,),
            const Text("Système d'Information sur les Marchés du Riz et de l'Oignon au Cameroun", textAlign: TextAlign.center,style: TextStyle(color: vertFort , fontWeight: FontWeight.bold , fontSize: 20)),
            const  SizedBox(height: 30,),
            Image.asset('assets/images/logo-simro.png'),
            const SizedBox(height: 60,),
            const CircularProgressIndicator(color: vert,),
            ],
          ),
        ),
      ),
    );
  }
}