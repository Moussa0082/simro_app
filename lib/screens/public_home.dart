import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/enquete_collecte.dart';
import 'package:simro/screens/enquete_consommation.dart';
import 'package:simro/screens/enquete_grossiste.dart';
import 'package:simro/screens/login.dart';
import 'package:simro/screens/prix_marche_collecte.dart';
import 'package:simro/screens/prix_marche_consommation.dart';
import 'package:simro/screens/prix_marche_grossiste.dart';
import 'package:simro/screens/products.dart';
import 'package:simro/widgets/pin_code.dart';
import 'package:simro/widgets/pin_code_login.dart';

class PublicHomeScreen extends StatefulWidget {
  const PublicHomeScreen({super.key});

  @override
  State<PublicHomeScreen> createState() => _PublicHomeScreenState();
}

class _PublicHomeScreenState extends State<PublicHomeScreen> {
  
    final List<String> imageList = [
    'assets/images/riz.jpeg',
    'assets/images/oignon-culture.jpg',
    'assets/images/mch.jpg',
  ];
  int _currentIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo-simro.png', // Remplacez par le chemin de votre logo
              height: 50,
            ),
            
            // Bouton Se connecter
            ElevatedButton.icon(
              onPressed: () {
                // Action pour le bouton
                Get.to(PinCodeLoginScreen(), transition: Transition.leftToRight, duration: Duration(seconds: 1));
              },
              icon: Icon(Icons.login, color: Colors.white),
              label: Text('Se connecter', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: vert, // Couleur de fond
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Bande verte avec le texte d'information
          // Container(
          //   padding: EdgeInsets.all(10.0),
          //   color: Colors.green[700],
          //   child: Center(
          //     child: Text(
          //       "System D'information® - sur les marchés\nAgricole du Riz et de l'oignon au ...",
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
          // Onglets pour les catégories avec possibilité de scroll horizontal
          Container(
            color: Colors.green[800],
            height: 50.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoryItem('CÉRÉALE'),
                  categoryItem('BULBE'),
                  categoryItem('SEMENCES'),
                  categoryItem('FRUITS'),
                  categoryItem('LÉGUMES'),
                  categoryItem('PRODUITS LAITIERS'),
                  categoryItem('VIANDE'),
                ],
              ),
            ),
          ),
          // Corps de la page avec les cartes de prix
          Expanded(
            child: ListView(
              children: [
                buildPriceCard(
                  'Riz Paddy',
                  'Sac',
                  'assets/images/riz.jpeg', // Remplacer par une vraie image
                  150,
                  215,
                  350,
                  '18/05/2023',
                  6,
                ),
                buildPriceCard(
                  'Riz Paddy',
                  'Sachet',
                  'assets/images/riz.jpeg', // Remplacer par une vraie image
                  150,
                  150,
                  150,
                  '10/05/2023',
                  1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour les éléments de la barre de catégorie
  Widget categoryItem(String categoryName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          categoryName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // Fonction pour créer une carte de prix
  Widget buildPriceCard(
      String productName,
      String packagingType,
      String imageUrl,
      int minPrice,
      int avgPrice,
      int maxPrice,
      String date,
      int marketCount) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image produit
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl, // Image statique
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.0),
                // Détails prix
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Prix (Fcfa)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPriceInfo('Minimum', minPrice),
                          _buildPriceInfo('Moyen', avgPrice),
                          _buildPriceInfo('Maximum', maxPrice),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // Nom du produit et type de packaging
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$productName ($packagingType)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Nombre de marché : $marketCount',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour construire les infos de prix
  Widget _buildPriceInfo(String label, int price) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          '$price',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}