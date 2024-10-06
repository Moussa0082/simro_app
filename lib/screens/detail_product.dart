import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/models/Produit_Info.dart';
import 'package:simro/models/Produit_With_Price.dart';

class DetailProductScreen extends StatefulWidget {
  ProduitAvecPrix? produit;
  Produit? produits;
   DetailProductScreen({super.key,  this.produit, this.produits});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}


class _DetailProductScreenState extends State<DetailProductScreen> {
  
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
 
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
                             child: widget.produit != null && widget.produit!.produit.image != null && 
                             widget.produit!.produit.image!.isNotEmpty ?
                            SizedBox(
                                    height: 200,
                                    width: double.infinity, // Occupe toute la largeur
                                    child: Image.network(
                                      widget.produit!.produit.image!,
                                      fit: BoxFit.cover, // Permet de s'assurer que l'image couvre tout en respectant le ratio
                                    ),
                                  ):
                            SizedBox(
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
                  buildDetailRow("Nom Produit:", widget.produit != null ? widget.produit!.produit.nom_produit! : widget.produits!.nom_produit! ?? "Inconnu"),
                  const Divider(thickness: 1),
                  buildDetailRow("Code Produit :" , widget.produit != null ? widget.produit!.produit.code_produit! : widget.produits!.code_produit! ?? "Inconnu"),
                 const Divider(thickness: 1),
                  buildDetailRow("Date d'ajout :", widget.produit != null ? widget.produit!.produit.date_enregistrement! : widget.produits!.date_enregistrement! ?? "Inconnu"),
                 const Divider(thickness: 1),
                  buildDetailRow("Prix Minimum :", widget.produit != null && widget.produit!.prixInfo.prix_min != null ? widget.produit!.prixInfo.prix_min.toString() : "0"),
                  buildDetailRow("Prix Moyen :", widget.produit != null && widget.produit!.prixInfo.prix_moy != null ? widget.produit!.prixInfo.prix_moy.toString() : "0"),
                  buildDetailRow("Prix Maximum :", widget.produit != null && widget.produit!.prixInfo.prix_max != null ? widget.produit!.prixInfo.prix_max.toString() : "0"),
                 const Divider(thickness: 1),
                  buildDetailRow("Origine Produit :", widget.produit != null && widget.produit!.produit.origine_produit != null ? widget.produit!.produit.origine_produit.toString() : widget.produits != null && widget.produits!.origine_produit != null ? widget.produits!.origine_produit.toString() : "Inconnu"),
                const  Divider(thickness: 1),
                  buildDetailRow("Famille produit :", widget.produit != null && widget.produit!.produit.famille_produit != null ? widget.produit!.produit.famille_produit.toString() : widget.produits != null && widget.produits!.famille_produit != null ? widget.produits!.famille_produit.toString() : "Inconnu"),
                 const Divider(thickness: 1),
                  buildDetailRow("Categorie :", widget.produit != null && widget.produit!.produit.categorie_produit != null ? widget.produit!.produit.categorie_produit.toString() : widget.produits != null && widget.produits!.categorie_produit != null ? widget.produits!.categorie_produit.toString() : "Inconnu"),
                const  Divider(thickness: 1),
                 const SizedBox(height: 20),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                label,
                style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                value.isEmpty ? "Null" : value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}