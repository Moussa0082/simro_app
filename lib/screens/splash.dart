import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
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

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{

   late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

 @override
  void initState() {
    // Initialiser les trois contrôleurs d'animation avec des durées différentes
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true, period: const Duration(milliseconds: 250));

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true, period: const Duration(milliseconds: 500));
    super.initState();
    // checkEnqueteurSession();
    requestPermissions();
   
  }

   @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
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


  // Demande de permissions pour la caméra, la galerie et d'autres services si nécessaire
Future<bool> requestPermissions() async {
  // Demander les permissions à l'utilisateur
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
    Permission.location,
  ].request();

  // Vérifier si toutes les permissions sont accordées
  bool allPermissionsGranted = statuses[Permission.camera]!.isGranted &&
      statuses[Permission.location]!.isGranted &&
      statuses[Permission.storage]!.isGranted;

  if (allPermissionsGranted) {
    print('Toutes les permissions ont été accordées');
    Get.off(const PublicHomeScreen());
  } else {
    // Si une ou plusieurs permissions sont refusées, afficher une boîte de dialogue
    _showDialog();
  }
  return allPermissionsGranted;
}

void _showDialog() {
  if (context.mounted) {
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche de fermer le pop-up en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions requises'),
          content: const Text(
              'Ces permissions sont nécessaires pour utiliser toutes les fonctionnalités de l\'application. Veuillez accorder les permissions.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue si l'utilisateur refuse
              },
            ),
            TextButton(
              child: const Text('Réessayer'),
              onPressed: () async {
                Navigator.of(context).pop(); // Ferme le dialogue
                await _retryPermissions(context);  // Redemande les permissions
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> _retryPermissions(BuildContext context) async {
  // Redemander les permissions une deuxième fois
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
    Permission.location,
  ].request();

  bool allPermissionsGranted = statuses[Permission.camera]!.isGranted &&
      statuses[Permission.location]!.isGranted &&
      statuses[Permission.storage]!.isGranted;

  if (allPermissionsGranted) {
    print('Toutes les permissions ont été accordées lors de la seconde demande.');
  } else if (context.mounted) {
    // Si encore refusé, afficher un autre message ou rediriger l'utilisateur vers les paramètres
    _showPermissionDeniedDialog(context);
  }
}

void _showPermissionDeniedDialog(BuildContext context) {
  if (context.mounted) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Permissions refusées'),
          content: const Text(
              'Les permissions sont nécessaires pour utiliser cette fonctionnalité. Vous pouvez accorder les permissions depuis les paramètres de l\'application.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Ferme le dialogue
              },
            ),
          ],
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
        // Simuler une attente avant la navigation
//     Future.delayed(const Duration(seconds: 2), () async {
//   // Attendre que la méthode asynchrone finisse de s'exécuter
//   bool permissionsGranted = await requestPermissions();

//   if (permissionsGranted) {
//     // Si les permissions sont accordées, naviguer vers la page suivante
//     checkEnqueteurSession();
//   }
// });


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
            // const CircularProgressIndicator(color: vert,),
            Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller1,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller1.value,
                  child: child,
                );
              },
              child: _buildDot(),
            ),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: _controller2,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller2.value,
                  child: child,
                );
              },
              child: _buildDot(),
            ),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: _controller3,
              builder: (context, child) {
                return Opacity(
                  opacity: _controller3.value,
                  child: child,
                );
              },
              child: _buildDot(),
            ),
          ],
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }


     // Fonction pour créer les points
  Widget _buildDot() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: vert,
        shape: BoxShape.circle,
      ),
    );
  }





}