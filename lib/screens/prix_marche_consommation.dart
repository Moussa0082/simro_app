import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Prix_Marche_Consommation.dart';
import 'package:simro/screens/add_prix_marche_consommation.dart';
import 'package:simro/screens/detail_marche.dart';
import 'package:simro/screens/detail_prix_marche_consommation.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/loading_over_lay.dart';
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
     
    List<PrixMarcheConsommation> fetchedList = await PrixMarcheService().fetchPrixMarcheConsommation().then((prixMarcheConsommation) {
  //    LocalDatabaseService().getAllEnquetes().then((enquete) {
  //   setState(() {
  //     enqueteCollecteList = enquete;
  //     // isLoading = false;
  //   });
  // });
    setState(() {
      prixMarcheConsommationList.addAll(prixMarcheConsommation);
    });
    return prixMarcheConsommationList;
  });
    
      prixMarcheConsommationList = fetchedList;
        // Retourner la liste mise à jour
    return prixMarcheConsommationList;
  } catch (e) {
    print("Erreur lors de la récupération des prix marche consommation : $e");
    return [];
  }
}

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     LocalDatabaseService().getAllPrixMarcheConsommation().then((value) {
             // Désactiver le chargement
             setState(() {
                prixMarcheConsommationList = value;
      isLoading = false;  
             });
     PrixMarcheService().fetchPrixMarcheConsommation().then((prixMarcheGrossiste){
    setState(() {
      prixMarcheConsommationList.addAll(prixMarcheGrossiste);  // Assigner les produits récupérés à la liste locale
    });
  });
 });
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
                              // if (result == 'synchroniser') {
                              //  showSyncDialog(context);
                              // }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'ajouter',
                                child: Text('Ajouter'),
                              ),
                              // PopupMenuItem<String>(
                              //   value: 'synchroniser',
                              //   child: Text('Synchroniser'),
                              // ),
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
                              Align(
                                  alignment: Alignment.topRight,
                                  child: filteredList[index].isSynced != null &&  filteredList[index].isSynced != 1  ? Icon(
                                 Icons.cloud_off,
                                color: filteredList[index].isSynced != 1 ? Colors.red :Colors.green ,
                              ) : SizedBox(),
                                ),
                              Text(
                                'Enquete : ${filteredList[index].enquete}',
                                 maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                              ),
                              SizedBox(height: 5),
                              Text('Produit : ${filteredList[index].produit}' ,
                               maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                  
                              Text('Poids unitaire : ${filteredList[index].poids_unitaire}' ,
                               maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              // Bouton avec trois points
                              PopupMenuButton<String>(
                                iconColor:vert,
                                onSelected: (String result) async{
                                  if (result == 'modifier') {
                                    // Action pour modifier
                                    Get.to(AddPrixMarcheConsommationScreen(isEditMode:true, prixMarcheConsommation:filteredList[index]));
                                    print('Modifier sélectionné');
                                  } else if (result == 'detail') {
                                    // Action pour détail
                                     Get.to(DetailPrixMarcheConsommationScreen(prixMarcheConsommation:filteredList[index] ,));

                                    print('Détail sélectionné');
                                  } 
                                  else if (result == 'synchroniser' && filteredList[index].isSynced != null &&  filteredList[index].isSynced != 1)  {
   showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
                                       try {
  //  DateTime parsedDate = DateTime.parse(enquete.date_enquete!);
                             PrixMarcheService().addPrixMarcheConsommation(enquete: filteredList[index].enquete!,
                              produit: filteredList[index].produit!, unite: filteredList[index].unite!, 
                              prix_mesure: filteredList[index].prix_mesure!,
                               poids_unitaire: filteredList[index].poids_unitaire!, 
                               prix_kg_litre: filteredList[index].prix_kg_litre!, app_mobile: filteredList[index].app_mobile!, 
                               niveau_approvisionement: filteredList[index].niveau_approvisionement!, statut: filteredList[index].statut!,
                                 id_personnel:filteredList[index].id_personnel!).then((value) {

    LocalDatabaseService().deletePrixMarcheConsommation(filteredList[index].id_fiche!).then((value) {
          hideLoadingDialog(context); // Cache le dialogue de chargement
    });
  });

   // Update the original list used by ListView.builder
                          setState(() {
                            prixMarcheConsommationList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche);
                          });
  // Appliquer les changements via le Provider
  Provider.of<PrixMarcheService>(context, listen: false).applyChange();

  // Récupérer la nouvelle liste d'enquêtes collectées
  List<PrixMarcheConsommation> nouvelleListe = await fetchPrixMarcheConsommation();

  // Mettre à jour l'état avec la nouvelle liste
  setState(() {
    isLoading = false;
    prixMarcheConsommationList = nouvelleListe;
  });


} catch (e) {
  final String errorMessage = e.toString();
  print("Erreur : " + errorMessage);

  // Gérer l'erreur ici
}
                                      print('Synchroniser sélectionné');
                                    } 
                                     else if (result == 'supprimee') {
                                      // Action pour supprimer
                                      LocalDatabaseService().deletePrixMarcheCollecte(filteredList[index].id_fiche!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            prixMarcheConsommationList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche);
                          });
                        });
                                      print('Supprimer sélectionné');
                                    }
                                  else if (result == 'supprimer') {
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
                                itemBuilder: (BuildContext context) => filteredList[index].isSynced != null &&  filteredList[index].isSynced != 1 ?   
                                     <PopupMenuEntry<String>>  [
                                
                                const   PopupMenuItem<String>(
                                      value: 'synchroniser',
                                      child: Text('Synchroniser'),
                                    ),
                                  const  PopupMenuItem<String>(
                                      value: 'detail',
                                      child: Text('Détail'),
                                    ),
                                  const  PopupMenuItem<String>(
                                      value: 'supprimee',
                                      child: Text('Supprimé'),
                                    ),
                           
                                  ] : 
                                  <PopupMenuEntry<String>>  [
                                
                                 const  PopupMenuItem<String>(
                                      value: 'modifier',
                                      child: Text('Modifier'),
                                    ),
                                 const   PopupMenuItem<String>(
                                      value: 'detail',
                                      child: Text('Détail'),
                                    ),
                                  const  PopupMenuItem<String>(
                                      value: 'supprimer',
                                      child: Text('Supprimer'),
                                    ),
                                  ] ,
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