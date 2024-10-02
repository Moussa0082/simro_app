import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Produit.dart';

class DetailProductScreen extends StatefulWidget {
  Produit? produit;
   DetailProductScreen({super.key,  this.produit});

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
                             child: widget.produit != null && widget.produit!.image != null && 
                             widget.produit!.image!.isNotEmpty ?
                            SizedBox(
                                    height: 200,
                                    width: double.infinity, // Occupe toute la largeur
                                    child: Image.network(
                                      widget.produit!.image!,
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
                  buildDetailRow("Nom Produit:", widget.produit!.nom_produit!),
                  Divider(thickness: 1),
                  buildDetailRow("Code Produit :" , widget.produit!.code_produit! ),
                  Divider(thickness: 1),
                  buildDetailRow("Date d'ajout :", widget.produit!.date_enregistrement!),
                  // Divider(thickness: 1),
                  // buildDetailRow("Etat :", widget.produit!.etat!),
                  // Divider(thickness: 1),
                  // buildDetailRow("Origine Produit :", widget.produit!.origine_produit!.toString()),
                  // Divider(thickness: 1),
                  // buildDetailRow("Famille produit :", widget.produit!.forme_produit!.toString()),
                  Divider(thickness: 1),
                  // buildDetailRow("Categorie :", widget.produit!.categorie_produit!.toString()),
                  // Divider(thickness: 1),
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