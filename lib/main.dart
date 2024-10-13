import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simro/controller/dependancy_injection.dart';
import 'package:simro/provider/Connectivity_Prodvider.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/splash.dart';
import 'package:simro/services/Connectivity_Service.dart';
import 'package:simro/services/Enquete_Service.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/widgets/Connectivity_Banner.dart';
import 'package:sqflite/sqflite.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Vérifiez la structure de la table, cela peut être déplacé si ce n'est pas urgent.
   // Supprimez l'ancienne base de données (si nécessaire)
    // await deleteDatabase("collecte.db");
  // Initialisez la base de données
  //  await LocalDatabaseService().initDB();
  // Initialise les dépendances
  DependancyInjection().init();
  
  // Exécutez l'application
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalDatabaseService()),
        ChangeNotifierProvider(create: (_) => EnqueteurProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityService()),
        ChangeNotifierProvider(create: (_) => EnqueteService()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
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
  }

  
  
   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
    
     return  GetMaterialApp(
      // initialRoute: '/splash', // Ou votre route initiale
      // getPages: [
      //   GetPage(name: '/splash', page: () => SplashScreen()),
        // Ajoutez d'autres pages ici
      // ],
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade, // Ou n'importe quelle autre transition
      theme: ThemeData(
           scaffoldBackgroundColor: Colors.white, // Couleur de fond pour toutes les pages
        // colorScheme: ColorScheme.fromSeed(seedColor: vert),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      // builder: (context, child) {
      //       return Stack(
      //         children: [
      //           child!,
      //           ConnectivityBanner(), // Affichez la bannière de connectivité ici
      //         ],
      //       );
      //     },
      
    );
     }
     );
  }
}




