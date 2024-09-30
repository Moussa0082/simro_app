import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Enqueteur.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/add_prix_marche_collecte.dart';
import 'package:simro/screens/add_prix_marche_consommation.dart';
import 'package:simro/screens/add_prix_marche_grossiste.dart';
import 'package:simro/screens/add_product.dart';
import 'package:simro/screens/enquete_collecte.dart';
import 'package:simro/screens/enquete_consommation.dart';
import 'package:simro/screens/enquete_grossiste.dart';
import 'package:simro/screens/prix_marche_collecte.dart';
import 'package:simro/screens/prix_marche_consommation.dart';
import 'package:simro/screens/prix_marche_grossiste.dart';
import 'package:simro/screens/products.dart';
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

   @override
  void initState() {
    super.initState();
      enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false).enqueteur!;
  }
 
  @override
  Widget build(BuildContext context) {

// Pour afficher uniquement une ligne avec la donnée du provider :


    return Scaffold(
      backgroundColor: background,
      appBar: ResponsiveAppBar(
    firstName: "${enqueteurProvider.prenom}",
    lastName: "${enqueteurProvider.nom}",
  ),
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
                color:griss,
                // elevation: 2,
                child: Padding(
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
                          Text('Consommation : ......', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          Text('Collecte : ......' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Grossiste : ......' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

                   SizedBox(
                    height: 260,
             child: GridView.count(
               crossAxisCount: 3, // 3 colonnes
               crossAxisSpacing: 10,
               mainAxisSpacing: 10,
               children: [
                 buildGridItem(Icons.bar_chart, 'Enquête de collecte', EnqueteCollecteScreen()),
                 buildGridItem(Icons.attach_money, 'Enquête de consommation', EnqueteConsommationScreen()),
                 buildGridItem(Icons.people, 'Enquête grossiste',EnqueteGrossisteScreen()),

          
             
                 buildGridItem(Icons.attach_money, 'Prix Marché Consommation', PrixMarcheConsommationScreen()),
                 buildGridItem(Icons.bar_chart, 'Prix Marché Collecte', PrixMarcheCollecteScreen()),
                 buildGridItem(Icons.people, 'Prix Marché Grossiste', PrixMarcheGrossisteScreen()),
             
                 // Dernière carte
                 
               ],
             ),
                   ),
          
             GestureDetector(onTap:(){

              Get.to(ProductsScreen(), transition: Transition.downToUp, duration: Duration(seconds: 1)) ;
             },
               child: Card(
                        // color:griss,
                           child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Icon(Icons.storage_outlined, color: vert,),
                              ),
                              ),
                  const SizedBox(height:5),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Produit', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 30,
                          width:30,
                          child: Image.asset("assets/images/db.png")),
                      ),
                    ],
                  ),
                            ],
                           ),
                          ),
             ),
             
            ],
          ),
        ),
      ),
    );
  }


  // Widget pour construire un item de la grille
 // Fonction pour créer un élément de grille avec un routage dynamique
 // Fonction pour créer un élément de grille avec un routage dynamique
Widget buildGridItem(IconData icon, String label, Widget destinationPage) {
  return GestureDetector(
    onTap: () {
      // Naviguer vers la page spécifiée
      Get.to(() => destinationPage, transition: Transition.downToUp, duration: Duration(seconds: 1));
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



}