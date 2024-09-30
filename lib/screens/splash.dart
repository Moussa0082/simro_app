import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
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
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PublicHomeScreen()),
        ),
      );
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