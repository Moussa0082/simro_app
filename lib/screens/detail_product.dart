import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  
  
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail Produit",style: TextStyle(color: blanc),),
        centerTitle: true,
        backgroundColor: vert,
                leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios, color: blanc)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                    height: 200,
                                    width: double.infinity, // Occupe toute la largeur
                                    child: Image.asset(
                                      "assets/images/riz.jpeg",
                                      fit: BoxFit.cover, // Permet de s'assurer que l'image couvre tout en respectant le ratio
                                    ),
                                  ),
                          ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailRow("Nom Produit:", "Marché Bamako"),
                  Divider(thickness: 1),
                  buildDetailRow("Code Produit :", "01"),
                  Divider(thickness: 1),
                  buildDetailRow("Date d'ajout :", "17/07/2024"),
                  Divider(thickness: 1),
                  buildDetailRow("Type Produit :", "Type exemple"),
                  Divider(thickness: 1),
                  buildDetailRow("Prix Produit :", "54"),
                  Divider(thickness: 1),
                  buildDetailRow("Grossiste :", "Aly Bah"),
                  Divider(thickness: 1),
                  buildDetailRow("CategorieProduit :", "Catgeorie"),
                  Divider(thickness: 1),
                  buildDetailRow("Origine :", "Bamako"),
                  Divider(thickness: 1),
                  SizedBox(height: 20),
                  // Center(
                    // child: ElevatedButton(
                    //   onPressed: () {
                    //     // Action à définir pour le bouton si besoin
                    //     print("Action sur le bouton");
                    //   },
                    //   child: Text("Action supplémentaire"),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: vert, // Couleur du bouton
                    //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    //   ),
                    // ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer chaque ligne de détail
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}