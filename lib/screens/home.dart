import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Enqueteur.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/add_prix_marche_collecte.dart';
import 'package:simro/screens/add_prix_marche_consommation.dart';
import 'package:simro/screens/add_prix_marche_grossiste.dart';
import 'package:simro/screens/add_product.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:simro/screens/enquete_collecte.dart';
import 'package:simro/screens/enquete_consommation.dart';
import 'package:simro/screens/enquete_grossiste.dart';
import 'package:simro/screens/prix_marche_collecte.dart';
import 'package:simro/screens/prix_marche_consommation.dart';
import 'package:simro/screens/prix_marche_grossiste.dart';
import 'package:simro/screens/products.dart';
import 'package:simro/screens/profil.dart';
import 'package:simro/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   final List<String> imageList = [
    'assets/images/riz.jpeg',
    'assets/images/oignon-culture.jpg',
    'assets/images/mch.jpg',
  ];
  int _currentIndex = 0;
  late Enqueteur enqueteurProvider;
      late TextEditingController _searchController;


   @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
      enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false).enqueteur!;
  }
 

 void _storeUserSession(String token, Enqueteur enqueteur) async {
  final prefs = await SharedPreferences.getInstance();
  
  // Stocker le token
  await prefs.setString('access_token', token);
  // Convertir l'objet Enqueteur en JSON
  String enqueteurJson = json.encode(enqueteur.toJson());
  // Stocker l'objet Enqueteur sous forme de chaîne JSON
  await prefs.setString('enqueteur', enqueteurJson);
}

Future<Map<String, dynamic>> getTotalEnquetes() async {
  // Récupérer l'instance de la base de données
final dbService = LocalDatabaseService();  // Créer une instance
final db = await dbService.database;       // Accéder à la méthode via l'instance
  
  // Exécuter la requête pour récupérer les totaux
  final result = await db.rawQuery('''
    SELECT 
      (SELECT COUNT(*) FROM enquete) AS total_consommation,
      (SELECT COUNT(*) FROM enquete_collecte) AS total_collecte,
      (SELECT COUNT(*) FROM enquete_grossiste) AS total_grossiste,
      (
        (SELECT COUNT(*) FROM enquete) +
        (SELECT COUNT(*) FROM enquete_collecte) +
        (SELECT COUNT(*) FROM enquete_grossiste)
      ) AS total_general;
  ''');

  // Vérification si la requête retourne des résultats
  if (result.isNotEmpty) {
    return result.first; // Retourner le premier résultat sous forme de Map
  } else {
    // Retourner des valeurs par défaut si aucun résultat n'est trouvé
    return {
      'total_consommation': 0,
      'total_collecte': 0,
      'total_grossiste': 0,
      'total_general': 0,
    };
  }
}



  @override
  Widget build(BuildContext context) {

// Pour afficher uniquement une ligne avec la donnée du provider :


    return Scaffold(
      backgroundColor: background,
      appBar:  _appBar(),
  //     ResponsiveAppBar(
  //   firstName: "${enqueteurProvider.prenom}",
  //   lastName: "${enqueteurProvider.nom}",
  // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image slider 
            
             Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.0, // Pour occuper toute la largeur
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: imageList.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(item),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                // Indicateur de page (dots)
                Positioned(
                  bottom: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => CarouselSlider(
                          options: CarouselOptions(
                            initialPage: entry.key,
                          ),
                          items: imageList.map((item) => Container()).toList(),
                        ),
                        child: Container(
                          width: _currentIndex == entry.key ? 12.0 : 8.0,
                          height: _currentIndex == entry.key ? 12.0 : 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : vert)
                                .withOpacity(
                                    _currentIndex == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
              
              const SizedBox(height: 16),

              // Total collectes d'enquête
             Container(
  color: griss,
  child: FutureBuilder<Map<String, dynamic>>(
    future: getTotalEnquetes(),
    builder: (context, snapshot) {
      // Gestion de l'état de la connexion
      if (snapshot.connectionState == ConnectionState.waiting) {
        return _buildShimmerEffect(); // Loader pendant le chargement
      }

      if (snapshot.hasError) {
        // Affiche un message d'erreur s'il y a un problème
        return Text('Erreur: ${snapshot.error}');
      }

      if (!snapshot.hasData || snapshot.data == null) {
        // Cas où il n'y a pas de données
        return Text('Aucune donnée trouvée.');
      }

      final data = snapshot.data!; // Extraction des données

      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Total de collectes d\'enquête de',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Consommation : ${data['total_consommation'] ?? "0"}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Collecte : ${data['total_collecte'] ?? "0"}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Grossiste : ${data['total_grossiste'] ?? "0"} ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    },
  ),
),

              const SizedBox(height: 16),

                   SizedBox(
                    height: 260,
             child: GridView.count(
               crossAxisCount: 3, // 3 colonnes
               crossAxisSpacing: 10,
               mainAxisSpacing: 10,
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(), // Désactive le scroll du GridView
               children: [
                 buildGridItem(Icons.bar_chart, 'Enquête de collecte', EnqueteCollecteScreen()),
                 buildGridItem(Icons.attach_money, 'Enquête ', EnqueteScreen()),
                 buildGridItem(Icons.people, 'Enquête grossiste',EnqueteGrossisteScreen()),
                 buildGridItem(Icons.attach_money, 'Prix Marché Consommation', PrixMarcheConsommationScreen()),
                 buildGridItem(Icons.bar_chart, 'Prix Marché Collecte', PrixMarcheCollecteScreen()),
                 buildGridItem(Icons.people, 'Prix Marché Grossiste', PrixMarcheGrossisteScreen()),
             
                 // Dernière carte
                 
               ],
             ),
                   ),
          
            //  GestureDetector(onTap:(){

            //   Get.to(ProductsScreen(), transition: Transition.downToUp, duration: Duration(seconds: 1)) ;
            //  },
            //    child: Card(
            //             // color:griss,
            //                child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: SizedBox(
            //         height: 20,
            //         width: 20,
            //         child: Icon(Icons.storage_outlined, color: vert,),
            //                   ),
            //                   ),
            //       // const SizedBox(height:5),
            //       Row(
            //         mainAxisAlignment:MainAxisAlignment.spaceBetween,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text('Produit', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: SizedBox(
            //               height: 30,
            //               width:30,
            //               child: Image.asset("assets/images/db.png")),
            //           ),
            //         ],
            //       ),
            //                 ],
            //                ),
            //               ),
            //  ),
             
            ],
          ),
        ),
      ),
    );
  }


  // Widget pour construire un item de la grille
  Widget buildGridItem(IconData icon, String label, Widget destinationPage) {
  return GestureDetector(
    onTap: () {
      // Naviguer vers la page spécifié
      Get.to(() => destinationPage, transition: Transition.downToUp);
    },
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // centrer le contenu
                children: [
                  Icon(icon, size: 40, color: vert),
                  SizedBox(height: 6),
                  // Utilisation de Flexible pour que le texte ne dépasse pas
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.left, // centrer le texte pour éviter des dépassements
                      maxLines: 2,
                      overflow:TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}


 Widget buildGridItemLarge(IconData leftIcon, IconData rightIcon, String label, Widget destinationPage) {
  return GestureDetector(
    onTap: () {
      // Naviguer vers la page spécifiée avec une transition
      Get.to(() => destinationPage, transition: Transition.downToUp, duration: Duration(seconds: 1));
    },
    child: Container(
      width: double.infinity, // Prend toute la largeur disponible
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icône à gauche
              Icon(leftIcon, size: 30, color: vert),
    
              // Texte centré
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
    
              // Icône à droite
              Icon(rightIcon, size: 30, color: vert),
            ],
          ),
        ),
      ),
    ),
  );
}


    PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(85),
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: _boxDecoration(),
        child: GestureDetector(
          onTap:(){
             Get.to(ProfilScreen(),transition: Transition.upToDown);
          },
          child: SafeArea(
            child: Column(
              children: [
                _topBar(),
                const SizedBox(height: 5),
                // _searchBox(),
                // _tabBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      gradient: LinearGradient(
        colors: [Colors.white, vert],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

 Widget _topBar() {
  return Row(
    children: [
      ProfilePhoto(
         onTap: () {
          print("Image de profil tapée !"); // More specific message
          Get.to(() => ProfilScreen(), transition: Transition.upToDown);
        },
        totalWidth: 50,
        cornerRadius: 50,
        color: Colors.white,
        image: AssetImage('assets/images/logo-simro.png'),
      ),
    Expanded(
  child: ListTile(
    title: Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        "Bienvenue",
        style: const TextStyle(
          color: blanc,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(left: 4.0), // Ajout du padding pour aligner à gauche
      child: Text(
        "${enqueteurProvider.prenom!} ${enqueteurProvider.nom!}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          color: blanc,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),

      // ProfilePhoto(
      //    onTap: () {
      //     print("Image de profil tapée !"); // More specific message
      //     Get.to(() => ProfilScreen(), transition: Transition.upToDown);
      //   },
      //   totalWidth: 50,
      //   cornerRadius: 50,
      //   color: Colors.black,
      //   image: AssetImage('assets/images/profil.jpg'),
      // ),
    ],
  );
}


  Widget _searchBox() {
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: InkWell(
            child: const Icon(Icons.close),
            onTap: () {
              _searchController.clear();
            },
          ),
          hintText: 'Search...',
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

  // Widget _tabBar() {
  //   return TabBar(
  //     labelPadding: const EdgeInsets.all(0),
  //     labelColor: Colors.black,
  //     indicatorColor: Colors.black,
  //     unselectedLabelColor: Colors.teal.shade800,
  //     tabs: const [
  //       Tab(
  //         iconMargin: EdgeInsets.all(0),
  //         icon: Icon(Icons.home),
  //         text: 'Home',
  //       ),
  //       Tab(
  //         iconMargin: EdgeInsets.all(0),
  //         icon: Icon(Icons.group),
  //         text: 'Group',
  //       ),
  //       Tab(
  //         iconMargin: EdgeInsets.all(0),
  //         icon: Icon(Icons.notifications),
  //         text: 'Notifications',
  //       ),
  //       Tab(
  //         iconMargin: EdgeInsets.all(0),
  //         icon: Icon(Icons.menu),
  //         text: 'Menu',
  //       ),
  //     ],
  //   );
  // }

  Widget _tabBarViewItem(IconData icon, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 100,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 40),
        ),
      ],
    );
  }
  

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 120.0,
                  height: 20.0,
                  color: Colors.grey,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100.0,
                  height: 20.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 80.0,
                height: 20.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

}