import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Prix_Marche_Grossiste.dart';
import 'package:simro/screens/add_prix_marche_grossiste.dart';
import 'package:simro/screens/detail_marche.dart';
import 'package:simro/screens/detail_prix_marche_grossiste.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/Snackbar.dart';
import 'package:simro/widgets/loading_over_lay.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class PrixMarcheGrossisteScreen extends StatefulWidget {
  const PrixMarcheGrossisteScreen({super.key});

  @override
  State<PrixMarcheGrossisteScreen> createState() => _PrixMarcheGrossisteScreenState();
}

class _PrixMarcheGrossisteScreenState extends State<PrixMarcheGrossisteScreen> {
  
  
  
  bool isLoading = true;
   bool isSyncing = false;
  late TextEditingController _searchController;


   List<PrixMarcheGrossiste> prixMarcheGrossisteList = [];
  
   Future<List<PrixMarcheGrossiste>> fetchPrixMarcheGrossiste() async {
  try {
    // Appel du service pour récupérer les données d'enquêtes
     
    List<PrixMarcheGrossiste> fetchedList = await LocalDatabaseService().getAllPrixMarcheGrossiste().then((prixMarcheGrossiste) {
  //    LocalDatabaseService().getAllEnquetes().then((enquete) {
    setState(() {
      prixMarcheGrossisteList = prixMarcheGrossiste;
      // isLoading = false;
    });
  // });

    return prixMarcheGrossisteList;
  });
    
      prixMarcheGrossisteList = fetchedList;
        // Retourner la liste mise à jour
    return prixMarcheGrossisteList;
  } catch (e) {
    print("Erreur lors de la récupération des prix marche collecte : $e");
    return [];
  }
}



 @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
   LocalDatabaseService().getAllPrixMarcheGrossiste().then((value) {
             // Désactiver le chargement
             setState(() {
                prixMarcheGrossisteList = value;
      isLoading = false;  
             });
    
 });
 
  }

 
@override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: Text("Prix marché grossite", style: TextStyle(color:blanc),),
        centerTitle: true,
        backgroundColor: vert,
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
                                Get.to(AddPrixMarcheGrossisteScreen(isEditMode: false,), transition: Transition.downToUp, duration: Duration(seconds: 1));
                              }
                              //      if (result == 'synchroniser') {
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
               textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              'Liste des prix du marché de grossiste',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: isLoading ? buildShimmerListCorE() :  Builder(
                builder: (context) {
                  String searchText = _searchController.text.toLowerCase();

                  // Filtrer la liste des enquetes en fonction du texte recherché
                  List<PrixMarcheGrossiste> filteredList = prixMarcheGrossisteList
                      .where((prixMarche) => prixMarche.id_fiche!.toString().toLowerCase().contains(searchText))
                      .toList();
                  // Afficher un message si aucun résultat n'est trouvé
              if (filteredList.isEmpty && !isLoading) {
                return const Center(
                  child: Text('Aucun résultat trouvé'),
                );
              }
             
                 
                  return ListView.builder(
                    itemCount: filteredList.length, // Par exemple, 3 fiches pour l'instant
                    itemBuilder: (context, index) {
                         final prixMarcheGrossiste = filteredList[index];
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
                                'Enquete: ${prixMarcheGrossiste.enquete}',
                                 maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                              ),
                              SizedBox(height: 5),
                              Text('Produit: ${prixMarcheGrossiste.produit}' ,
                               maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              SizedBox(height: 5),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                  
                              Text(' Nombre unité en stock : ${prixMarcheGrossiste.nombre_unite_stock} ' ,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              // Bouton avec trois points
                              PopupMenuButton<String>(
                                iconColor:vert,
                                onSelected: (String result) async{
                                  if (result == 'modifier') {
                                    // Action pour modifier
                                    Get.to(AddPrixMarcheGrossisteScreen(isEditMode:true, prixMarcheGrossiste:filteredList[index]));
                                    print('Modifier sélectionné');
                                  } else if (result == 'detail') {
                                    // Action pour détail
                             Get.to(DetailPrixMarcheGrossisteScreen(prixMarcheGrossiste:filteredList[index] ,));

                                    print('Détail sélectionné');
                                  } 
                                  else if (result == 'synchroniser' && filteredList[index].isSynced != null &&  filteredList[index].isSynced != 1)  {
   showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
                                       try {
  //  DateTime parsedDate = DateTime.parse(enquete.date_enquete!);
                                await PrixMarcheService().addPrixMarcheGrossiste(
                                      enquete:filteredList[index].enquete! ,
                                // enquete: filteredList[index].enquete!, 
                                localite_vente:filteredList[index].localite_vente!,
                                produit: filteredList[index].produit!, unite_stock: filteredList[index].unite_stock!, 
                                poids_moyen_unite_stock: filteredList[index].poids_moyen_unite_stock!, nombre_unite_stock: filteredList[index].nombre_unite_stock!,
                                 poids_stock: filteredList[index].poids_stock!,  nombre_unite_achat: filteredList[index].nombre_unite_achat!,
                                  unite_achat: filteredList[index].unite_achat!, poids_moyen_unite_achat: filteredList[index].poids_moyen_unite_achat!, 
                                  poids_total_achat: filteredList[index].poids_total_achat!, app_mobile: filteredList[index].app_mobile!, fournisseur_achat: filteredList[index].fournisseur_achat!,
                                   localite_achat: filteredList[index].localite_achat!, nombre_unite_vente: filteredList[index].nombre_unite_vente!,
                                 unite_vente:filteredList[index].unite_vente!,
                                client_vente:filteredList[index].client_vente! ,
                                   statut: filteredList[index].statut!, poids_moyen_unite_vente: filteredList[index].poids_moyen_unite_vente!,
                                    poids_total_unite_vente: filteredList[index].poids_total_unite_vente!,
                                      prix_unitaire_vente: filteredList[index].prix_unitaire_vente!.toDouble(),
                                     id_personnel: filteredList[index].id_personnel!).then((value) {
     if(value != null){
      
    LocalDatabaseService().deletePrixMarcheGrossiste(filteredList[index].id_fiche!).then((value) {
          hideLoadingDialog(context); // Cache le dialogue de chargement
                          setState(() {
                            prixMarcheGrossisteList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche);
                          });
    });
     }else{
      Snack.error(titre: "Erreur", message: "Une erreur s'est produite veuillez réessayer plus tard");
     }
  });

   // Update the original list used by ListView.builder
  // Appliquer les changements via le Provider
  Provider.of<PrixMarcheService>(context, listen: false).applyChange();

  // Récupérer la nouvelle liste d'enquêtes collectées
  List<PrixMarcheGrossiste> nouvelleListe = await fetchPrixMarcheGrossiste();

  // Mettre à jour l'état avec la nouvelle liste
  setState(() {
    isLoading = false;
    prixMarcheGrossisteList = nouvelleListe;
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
                                      LocalDatabaseService().deletePrixMarcheGrossiste(filteredList[index].id_fiche!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            prixMarcheGrossisteList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche);
                          });
                        });
                                      print('Supprimer sélectionné');
                                    }
                                  else if (result == 'supprimer') {
// Action pour supprimer
                                      PrixMarcheService().deletePrixMarcheGrossiste(filteredList[index].id_fiche!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            prixMarcheGrossisteList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche!);
                          });
                        });                                    print('Supprimer sélectionné');
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