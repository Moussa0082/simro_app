import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Prix_Marche_Consommation.dart';
import 'package:simro/screens/add_prix_marche_consommation.dart';
import 'package:simro/screens/detail_marche.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class PrixMarcheConsommationScreen extends StatefulWidget {
  const PrixMarcheConsommationScreen({super.key});

  @override
  State<PrixMarcheConsommationScreen> createState() => _PrixMarcheConsommationScreenState();
}

class _PrixMarcheConsommationScreenState extends State<PrixMarcheConsommationScreen> {
  
    late TextEditingController _searchController;
     bool isLoading = true;
   List<PrixMarcheConsommation> prixMarcheConsommationList = [];
  
     Future<List<PrixMarcheConsommation>> fetchPrixMarcheConsommation() async {
  try {
    // Appel du service pour récupérer les données d'enquêtes
     
    List<PrixMarcheConsommation> fetchedList = await PrixMarcheService().fetchPrixMarcheConsommation().then((prixMarche) {

    setState(() {
      prixMarcheConsommationList = prixMarche;
      isLoading = false;
    });
    return prixMarcheConsommationList;
  });
      prixMarcheConsommationList = fetchedList;
    
    // Mettre à jour la liste locale avec les nouvelles données    
    // Retourner la liste mise à jour
    return prixMarcheConsommationList;
  } catch (e) {
    print("Erreur lors de la récupération des prix marché consommation : $e");
    return [];
  }
}

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPrixMarcheConsommation();
    _searchController = TextEditingController();
  }

  
 
@override
  Widget build(BuildContext context) {



  
    return Scaffold(
      appBar: AppBar(
        title: Text("Prix marché de consommation", style: TextStyle(color:blanc),),
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
                                Get.to(AddPrixMarcheConsommationScreen(isEditMode:false), transition: Transition.downToUp);
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
              'Liste des prix du marché de consomation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

             Expanded(
              child: isLoading ? buildShimmerListCorE() :  Builder(
                builder: (context) {

                      String searchText = _searchController.text.toLowerCase();

                  // Filtrer la liste des enquetes en fonction du texte recherché
                  List<PrixMarcheConsommation> filteredList = prixMarcheConsommationList
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
                                'N° fiche: 01',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                              ),
                              SizedBox(height: 5),
                              Text('Marché enquête: Bamako' ,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              SizedBox(height: 5),
                              Text('Date Enquête: le 17/07/2024' ,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              // SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                  
                              Text('Date Enquête: le 17/07/2024' ,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              // Bouton avec trois points
                              PopupMenuButton<String>(
                                iconColor:vert,
                                onSelected: (String result) {
                                  if (result == 'modifier') {
                                    // Action pour modifier
                                    Get.to(AddPrixMarcheConsommationScreen(isEditMode:true, prixMarcheConsommation:filteredList[index]));
                                    print('Modifier sélectionné');
                                  } else if (result == 'detail') {
                                    // Action pour détail
                                    print('Détail sélectionné');
                                  } else if (result == 'supprimer') {
// Action pour supprimer
                                      PrixMarcheService().deletePrixMarcheConsommation(filteredList[index].id_fiche!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            prixMarcheConsommationList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche!);
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