import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Categorie_Produit.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/models/Produit_Info.dart';
import 'package:simro/models/Produit_With_Price.dart';
import 'package:simro/screens/detail_product.dart';
import 'package:simro/screens/enquete_collecte.dart';
import 'package:simro/screens/enquete_consommation.dart';
import 'package:simro/screens/enquete_grossiste.dart';
import 'package:simro/screens/login.dart';
import 'package:simro/screens/prix_marche_collecte.dart';
import 'package:simro/screens/prix_marche_consommation.dart';
import 'package:simro/screens/prix_marche_grossiste.dart';
import 'package:simro/screens/products.dart';
import 'package:simro/services/Categorie_Produit_Service.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/services/Produit_Service.dart';
import 'package:simro/widgets/pin_code.dart';
import 'package:simro/widgets/pin_code_login.dart';
import 'package:simro/widgets/shimmer_effect.dart';

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
  // int _currentIndex = 0;
   bool isLoading = true;
   bool isLoadingP = true;
    // List<Produit> produitList = [];
      int? selectedCategoryIndex ;
     List<CategorieProduit> categorieList = [];

  List<ProduitAvecPrix> produitList = [];

 Future<void> loadData() async {
  List<Produit> produits = await ProduitService().fetchProduit();
  List<PrixInfo> prixProduits = await PrixMarcheService().fetchPrixInfo();

  setState(() {
    produitList = produits.map((produit) {
      // Trouver les prix correspondants au produit
      PrixInfo? prixAssocie = prixProduits.firstWhere(
        (prix) => prix.produit == produit.nom_produit,
        orElse: () => PrixInfo(prix_min: 0, prix_max: 0, prix_moy: 0),
      );

      // Retourne un ProduitAvecPrix
      return ProduitAvecPrix(
        produit: produit,
        prixInfo: prixAssocie,
      );
    }).toList();
  });
}

  



  //   Future<void> fetchProduit() async {
  //   try {
  //     final produits = await ProduitService().fetchProduit(); // Assurez-vous que cette méthode retourne bien une liste de produits
  //     setState(() {
  //       produitList = produits;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Erreur de récupération des produits : $e');
  //   }
    
  // }


   @override
  void initState() {
    loadData().then((value) => {
      setState(() {
        isLoadingP = false;
      })
    });
    CategorieProduitService().fetchCategorie().then((value) => {
  setState(() {
      categorieList = value;
      isLoading = false;
  })      
    });
    super.initState();
  }
 

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
          isLoading ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: shimmerEffectCatPubHome(),
          ) :
          // Container(
          //     color: Colors.green[800],
          //     width: double.infinity,
          //     height: 50.0,
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: List.generate(
          //           categorieList.length,
          //           (index) => categoryItem(categorieList[index].nom_categorie_produit!, index),
          //         ),
          //       ),
          //     ),
          //   ),
         Container(
  color: Colors.green[800],
  width: MediaQuery.of(context).size.width,  // Occuper toute la largeur de l'écran
  height: 50.0,
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        categorieList.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: categoryItem(categorieList[index].nom_categorie_produit!, index),
        ),
      ),
    ),
  ),
),


  
          // Corps de la page avec les cartes de prix
           Expanded(
            child: 
      isLoadingP ? 
                ListView.builder(
                  itemCount: 6, // Nombre de shimmer cards que vous voulez afficher
                  itemBuilder: (context, index) {
                    return buildShimmerCardPublicHomme();
                  },
                )
                : ListView.builder(
  itemCount: produitList.length,
  itemBuilder: (context, index) {
    final produit = produitList[index];
    return GestureDetector(
      onTap: (){
        Get.to(DetailProductScreen(produit: produit,), transition: Transition.downToUp, duration: const Duration(seconds: 1));
      },
      child: buildPriceCard(
        produit.produit.nom_produit ?? 'Nom Indisponible',  // Vérification du nom produit
        // "packagingType",   // Vérification du type de packaging
        produit.produit.image?.isNotEmpty == true ? produit.produit.image! : '',  // Vérification de l'image
        produit.prixInfo.prix_min!.toInt(),  // Prix statiques
        produit.prixInfo.prix_moy!.toInt(),  // Prix statiques
        produit.prixInfo.prix_max!.toInt(),  // Prix statiques
        produit.prixInfo.dernier_date ?? 'Date inconnue',  // Vérification de la date
        produit.prixInfo.nb_marche ?? 0,  // Nombre de marchés statiques
      ),
    );
  },
),

          ),
        ],
      ),
    );
  }

  Widget buildPriceCard(
    String productName,
    // String packagingType,
    String imageUrl,
    int minPrice,
    int avgPrice,
    int maxPrice,
    String date,
    int marketCount,
  ) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child:
                  imageUrl.isEmpty ?
                  Image.asset(
                                                                  "assets/images/riz.jpeg",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 80,
                                                                  width:80,
                                                                ) :
                                                                Image.network(imageUrl,fit: BoxFit
                                                                      .cover,
                                                                  height: 80,
                                                                  width:80),
                  //  CachedNetworkImage(
                  //   imageUrl: imageUrl, // Image dynamique
                  //   width: 80,
                  //   height: 80,
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) => Center(child: const CircularProgressIndicator(color: vert,)),
                  //   errorWidget: (context, url, error) => const Icon(Icons.error),
                  // ),
                ),
              const  SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Center(
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.yellow, // Définir la couleur ici
      border: Border.all(color: Colors.yellow),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
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
                        overflow:TextOverflow.ellipsis,
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
          const  SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '$productName',
                      // '$productName ($packagingType)',
                      overflow:TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Nombre de marché : $marketCount',
                      overflow:TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Widget categoryItem(String categoryName, int index) {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         selectedCategoryIndex = index; // Met à jour lorsque l'utilisateur sélectionne
//       });
//     },
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             categoryName,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: selectedCategoryIndex == index
//                   ? FontWeight.bold
//                   : FontWeight.normal,
//             ),
//           ),
//           SizedBox(height: 4.0), // Espace entre le texte et le trait
//           if (selectedCategoryIndex == index)
//             Container(
//               height: 2.0,
//               width: double.infinity, // Occupe toute la largeur disponible
//               color: Colors.white, // Couleur du trait
//             ),
//         ],
//       ),
//     ),
//   );
// }

 Widget categoryItem(String categoryName, int index) {
  return GestureDetector(
    onTap: () {
      setState(() {
        print("nom" + categoryName);
        selectedCategoryIndex = index;  // Supposons que tu utilises un index pour marquer la sélection
      });
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      // decoration: BoxDecoration(
      //   color: selectedCategoryIndex == index ? Colors.yellow : Colors.green[600],
        // borderRadius: BorderRadius.circular(20.0),
      // ),
      child: Center(
        child: Text(
          categoryName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}



  Widget _buildPriceInfo(String label, int price) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(
          '$price',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}