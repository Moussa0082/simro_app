import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/splash.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EnqueteurProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    @override
  void initState() {
    super.initState();
    requestPermissions(context); // Demander les permissions dès l'init
  }

  // Demande de permissions pour la caméra, la galerie et d'autres services si nécessaire
  
Future<void> requestPermissions(BuildContext context) async {
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
  } else {
    // Si une ou plusieurs permissions sont refusées, afficher une boîte de dialogue
    if(mounted)
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche de fermer le pop-up en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permissions requises'),
          content: Text(
              'Ces permissions sont nécessaires pour utiliser toutes les fonctionnalités de l\'application. Veuillez accorder les permissions.'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue si l'utilisateur refuse
              },
            ),
            TextButton(
              child: Text('Réessayer'),
              onPressed: () async {
                Navigator.of(context).pop(); // Ferme le dialogue
                _retryPermissions(context);  // Redemande les permissions
              },
            ),
          ],
        );
      },
    );
  }
}

void _retryPermissions(BuildContext context) async {
  // Redemander les permissions une deuxième fois
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
    Permission.location,
  ].request();

  bool allPermissionsGranted = statuses[Permission.camera]!.isGranted &&
      statuses[Permission.location]!.isGranted &&
      statuses[Permission.storage]!.isGranted;

  if (!allPermissionsGranted) {
    // Si encore refusé, redemander ou afficher un autre message
    _showPermissionDeniedDialog(context);
  }
}

// Montre un message si les permissions sont refusées après la deuxième demande
void _showPermissionDeniedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Permissions refusées'),
        content: Text(
            'Les permissions sont nécessaires pour utiliser cette fonctionnalité. L\'application ne pourra pas fonctionner correctement sans ces permissions.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialogue
            },
          ),
        ],
      );
    },
  );
}
  
   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        // colorScheme: ColorScheme.fromSeed(seedColor: vert),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      
    );
  }
}




