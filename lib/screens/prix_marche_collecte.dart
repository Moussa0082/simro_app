import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/controller/network_controller.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Prix_Marche_Collecte.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/add_prix_marche_collecte.dart';
import 'package:simro/screens/detail_enquete_collecte.dart';
import 'package:simro/screens/detail_marche.dart';
import 'package:simro/screens/detail_prix_marche_collecte.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/Snackbar.dart';
import 'package:simro/widgets/loading_over_lay.dart';
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
     
    List<PrixMarcheCollecte> fetchedList = await LocalDatabaseService().getAllPrixMarcheCollecte().then((prixMarcheCollecte) {
  //    LocalDatabaseService().getAllEnquetes().then((enquete) {
    setState(() {
      prixMarcheCollecteList = prixMarcheCollecte;
      // isLoading = false;
    });
  // });
 
    return prixMarcheCollecteList;
  });
    
      prixMarcheCollecteList = fetchedList;
        // Retourner la liste mise à jour
    return prixMarcheCollecteList;
  } catch (e) {
    print("Erreur lors de la récupération des prix marche collecte : $e");
    return [];
  }
}


 @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
   LocalDatabaseService().getAllPrixMarcheCollecte().then((value) {
             // Désactiver le chargement
             setState(() {
                prixMarcheCollecteList = value;
      isLoading = false;  
             });
     
 });

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
                Get.offAll( const HomeScreen(), transition: Transition.leftToRight);
              },
              icon: const Icon(Icons.arrow_back_ios, color: blanc)),
              actions:[
                // Bouton avec trois points
                          PopupMenuButton<String>(
                            iconColor:blanc,
                            onSelected: (String result) {
                              // if (result == 'ajouter') {
                              //   Get.to(AddPrixMarcheCollecteScreen(isEditMode: false,), transition: Transition.downToUp);
                              // }
                              // if (result == 'synchroniser') {
                              //  showSyncDialog(context);
                              // }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              // PopupMenuItem<String>(
                              //   value: 'ajouter',
                              //   child: Text('Ajouter'),
                              // ),
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
                      final prixMarche = filteredList[index];

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
                                  onSelected: (String result) async{
                                    if (result == 'modifier') {
                                      // Action pour modifier
                                      Get.to(AddPrixMarcheCollecteScreen(isEditMode: true, prixMarcheColecte: filteredList[index],));
                                      print('Modifier sélectionné');
                                    } else if (result == 'detail') {
                                      // Action pour détail
                                      Get.to(DetailPrixMarcheCollecteScreen(prixMarcheCollecte:filteredList[index] ,));
                                      print('Détail sélectionné');
                                    } 
                                       else if (result == 'synchroniser' && prixMarche.isSynced != null &&  prixMarche.isSynced != 1)  {
                                            final st =  Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;
    if(st == false){
      ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: const Text("Connectez-vous à internet pour pouvoir synchroniser")),
              duration: Duration(seconds: 5), // Garde le SnackBar affiché
              backgroundColor: Colors.red,
//               action: SnackBarAction(
//                 label: 'OK',
//                 onPressed: () {
// ScaffoldMessenger.of(context).hideCurrentSnackBar();                  // Optionnel : ajouter une action pour que l'utilisateur puisse le masquer manuellement
//                 },
//               ),
            ),
          );
    }
   showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
                                       try {
  //  DateTime parsedDate = DateTime.parse(enquete.date_enquete!);
  await PrixMarcheService().addPrixMarcheCollecte(
    enquete:filteredList[index].enquete! ,
                              produit: filteredList[index].produit!, unite: filteredList[index].unite!, 
                              poids_unitaire: filteredList[index].poids_unitaire!, 
                              montant_achat: filteredList[index].montant_achat!,
                              prix_fg_kg: filteredList[index].prix_fg_kg!, 
                              distance_origine_marche: filteredList[index].distance_origine_marche!,
                               montant_transport: filteredList[index].montant_transport!,
                                app_mobile:1,
                                 quantite_collecte: filteredList[index].quantite_collecte!,
                                 client_principal: filteredList[index].client_principal!, 
                                 fournisseur_principal: filteredList[index].fournisseur_principal!,
                                 niveau_approvisionement: filteredList[index].niveau_approvisionement!, statut: filteredList[index].statut!,
                                  localite_origine: filteredList[index].localite_origine!, 
                                  etat_route: filteredList[index].etat_route!,
                                    id_personnel: filteredList[index].id_personnel!
                                    
    
  ).then((value) => {
    if(value != null){
      LocalDatabaseService().deletePrixMarcheCollecte(prixMarche.id_fiche!).then((value) {

          hideLoadingDialog(context); // Cache le dialogue de chargement
setState(() {
  
  prixMarcheCollecteList.removeWhere((item) => item.id_fiche == prixMarche.id_fiche);
});
    })
    }else{
      Snack.error(titre: "Erreur", message: "Une erreur s'est produite veuillez réessayer plus tard")
     }
    
  });

  // Appliquer les changements via le Provider
  Provider.of<PrixMarcheService>(context, listen: false).applyChange();

  // Récupérer la nouvelle liste d'enquêtes collectées
  List<PrixMarcheCollecte> nouvelleListe = await fetchPrixMarcheCollecte();

  // Mettre à jour l'état avec la nouvelle liste
  setState(() {
    isLoading = false;
    prixMarcheCollecteList = nouvelleListe;
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
                            prixMarcheCollecteList.removeWhere((item) => item.id_fiche == filteredList[index].id_fiche);
                          });
                        });
                                      print('Supprimer sélectionné');
                                    }
                                    else if (result == 'supprimer') {
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