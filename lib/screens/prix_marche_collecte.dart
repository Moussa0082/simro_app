import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Prix_Marche_Collecte.dart';
import 'package:simro/screens/add_prix_marche_collecte.dart';
import 'package:simro/screens/detail_marche.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class PrixMarcheCollecteScreen extends StatefulWidget {
  const PrixMarcheCollecteScreen({super.key});

  @override
  State<PrixMarcheCollecteScreen> createState() => _PrixMarcheCollecteScreenState();
}

class _PrixMarcheCollecteScreenState extends State<PrixMarcheCollecteScreen> {

   bool isLoading = true;
   bool isSyncing = false;
  late TextEditingController _searchController;


       List<PrixMarcheCollecte> prixMarcheCollecteList = [];
  
     Future<List<PrixMarcheCollecte>> fetchPrixMarcheCollecte() async {
  try {
    // Appel du service pour récupérer les données d'enquêtes
     
    List<PrixMarcheCollecte> fetchedList = await PrixMarcheService().fetchPrixMarcheCollecte().then((prixMarche) {

    setState(() {
      prixMarcheCollecteList = prixMarche;
      isLoading = false;
    });
    return prixMarcheCollecteList;
  });
      prixMarcheCollecteList = fetchedList;
    
    // Mettre à jour la liste locale avec les nouvelles données    
    // Retourner la liste mise à jour
    return prixMarcheCollecteList;
  } catch (e) {
    print("Erreur lors de la récupération des prix marché collecte : $e");
    return [];
  }
}


 @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
    fetchPrixMarcheCollecte();
  }
  
 
@override
  Widget build(BuildContext context) {

  

    return Scaffold(
      appBar: AppBar(
        title: Text("Prix marché de collecte", style: TextStyle(color:blanc),),
        centerTitle: true,
        backgroundColor: vert,
        leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios, color: blanc)),
              actions:[
                // Bouton avec trois points
                          PopupMenuButton<String>(
                            iconColor:blanc,
                            onSelected: (String result) {
                              if (result == 'ajouter') {
                                Get.to(AddPrixMarcheCollecteScreen(isEditMode: false,), transition: Transition.downToUp);
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Zone de recherche
                  Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                  onChanged: (value) {
                setState(() {
                  // Mettre à jour l'état à chaque saisie
                });
              },
                controller: _searchController,
                decoration: InputDecoration(
                  
                   contentPadding: EdgeInsets.all(10),
                  hintText: "recherche .............",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Liste des prix de marché de consommation
            Text(
              'Liste des prix du marché de collecte',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
              Expanded(
               child: isLoading ? buildShimmerListCorE() :  Builder(
                 builder: (context) {
                   String searchText = _searchController.text.toLowerCase();

                  // Filtrer la liste des enquetes en fonction du texte recherché
                  List<PrixMarcheCollecte> filteredList = prixMarcheCollecteList
                      .where((prixMarche) => prixMarche.id_fiche!.toString().toLowerCase().contains(searchText))
                      .toList();

                  // Afficher un message si aucun résultat n'est trouvé
                 // Afficher un message si aucun résultat n'est trouvé
              if (filteredList.isEmpty && !isLoading) {
                return const Center(
                  child: Text('Aucun résultat trouvé'),
                );
              }
                   return ListView.builder(
                    
                      itemCount: filteredList.length, // Par exemple, 3 fiches pour l'instant
                      itemBuilder: (context, index) {
                      
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                   maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                  'Localité : ${filteredList[index].localite_origine}',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                                ),
                                SizedBox(height: 5),
                                Text('Quantité collecté: ${filteredList[index].quantite_collecte}' ,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                    
                                Text('Etat de la route: ${filteredList[index].etat_route}' ,
                                 maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                                // Bouton avec trois points
                                PopupMenuButton<String>(
                                  iconColor:vert,
                                  onSelected: (String result) {
                                    if (result == 'modifier') {
                                      // Action pour modifier
                                      Get.to(AddPrixMarcheCollecteScreen(isEditMode: true, prixMarcheColecte: filteredList[index],));
                                      print('Modifier sélectionné');
                                    } else if (result == 'detail') {
                                      // Action pour détail
                                      Get.to(DetailMarcheScreen());
                                      print('Détail sélectionné');
                                    } else if (result == 'supprimer') {
                                      // Action pour supprimer
                                      // Action pour supprimer
                                      PrixMarcheService().deletePrixMarcheCollecte(filteredList[index].id_fiche!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            prixMarcheCollecteList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche!);
                          });
                        });
                                      print('Supprimer sélectionné');
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'modifier',
                                      child: Text('Modifier'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'detail',
                                      child: Text('Détail'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'supprimer',
                                      child: Text('Supprimer'),
                                    ),
                                  ],
                                ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                 }
               ),
             ),
              
            
          ],
        ),
      ),
     
    );
  }




}