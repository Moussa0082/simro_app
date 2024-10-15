import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/models/Produit_Info.dart';
import 'package:simro/models/Produit_With_Price.dart';
import 'package:simro/screens/add_product.dart';
import 'package:simro/screens/detail_product.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/services/Produit_Service.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
 
 bool isLoading = true;
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      // Appel pour récupérer les produits au chargement de la page
    loadData().then((value) => {
      setState(() {
        isLoading = false;
      })
    });

  }

  
 
@override
  Widget build(BuildContext context) {

  // Simuler un délai de 4 secondes avant de charger les données
 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: vert,
        centerTitle: true,
        title: Text('Liste produit', style: TextStyle(color: blanc)),
        // backgroundColor: Colors.grey[200], // Light gray background like in your image
        elevation: 0, // Remove shadow under the AppBar
        iconTheme: IconThemeData(color: Colors.black), // Black icons for back button, etc.
        leading: IconButton(
              onPressed: () {
                Get.offAll( const HomeScreen(), transition: Transition.leftToRight);
              },
              icon: const Icon(Icons.arrow_back_ios, color: blanc)),
               actions:[
                // Bouton avec trois points
                          PopupMenuButton<String>(
                            iconColor:blanc,
                            onSelected: (String result) {
                              if (result == 'ajouter') {
                                Get.to(AddProductScreen(), transition: Transition.downToUp, duration: Duration(seconds: 1));
                              }
                               if (result == 'synchroniser') {
                               showSyncDialog(context);
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'ajouter',
                                child: Text('Ajouter'),
                              ),
                              PopupMenuItem<String>(
                                value: 'synchroniser',
                                child: Text('Synchroniser'),
                              ),
                            ],
                          ),
              ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner image
              Stack(
                children: [
                  Image.asset(
                    'assets/images/riz.jpeg', // Path to your banner image
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
              // Titre "SIMRO"
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                child: Text(
                  "SIMRO",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
                ],
              ),
              SizedBox(height: 10),
              
              SizedBox(height: 10),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Recherche...',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                   
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Filter buttons
               isLoading
            ? buildShimmerFilterButtons() // Affiche le shimmer si les filtres sont en chargement
            :
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    _buildFilterButton("Siguiri"),
                    _buildFilterButton("Faranah"),
                    _buildFilterButton("Kindia"),
                    _buildFilterButton("Labé"),
                    _buildFilterButton("Listes"),
                  ],
                ),
              ),

              SizedBox(height: 10),

               isLoading ? buildShimmerProductGrid() :
              // Product grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7, // Adjust to get the correct card height
                ),
                itemCount: produitList.length, // Example product count
                itemBuilder: (context, index) {
                  final produit = produitList[index];
                    return  GestureDetector(
      onTap: () {
        Get.to(DetailProductScreen(produit: produit,), transition: Transition.downToUp, duration: Duration(seconds: 1));
      },
                      child: _buildProductCard(produit)); // Passer le produit au widget
                },
              ),

              SizedBox(height: 20),

             
            ],
          ),
        ),
      ),
    );
  }

  // Helper to create filter buttons
  Widget _buildFilterButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.grey[200], // Background color for filter buttons
        foregroundColor: Colors.black, // Text color
      ),
      child: Text(label),
    );
  }

  Widget _buildProductCard(ProduitAvecPrix produit) {
  return Card(
    // margin: EdgeInsets.all(2),
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Product image
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
          child:
           produit.produit.image != null && produit.produit.image!.isNotEmpty
              ? Image.network(
                  produit.produit.image!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/riz.jpeg',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                produit.produit.nom_produit ?? "Non defini",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Assurez-vous que la taille du texte est correcte
                ),
                maxLines: 1, // Limiter à une ligne si nécessaire
                overflow: TextOverflow.ellipsis, // Ajouter des points de suspension si le texte dépasse
              ),

              SizedBox(height: 4),
              Text(
                "Unité: ${produit.prixInfo.unite != null ? produit.prixInfo.unite : "Inconnu" }",
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text('Nobre de marché: ${produit.prixInfo.nb_marche != null ? produit.prixInfo.nb_marche : "Inconnu" }',
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
            Text(
                "Origine  ${produit.produit.origine_produit != null ? produit.produit.origine_produit.toString()  : "Inconnu"}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Assurez-vous que la taille du texte est correcte
                ),
                maxLines: 1, // Limiter à une ligne si nécessaire
                overflow: TextOverflow.ellipsis, // Ajouter des points de suspension si le texte dépasse
              ),
              
            ],
          ),
        ),
      ],
    ),
  );
}

}