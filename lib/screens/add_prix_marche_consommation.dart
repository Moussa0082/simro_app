import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/controller/network_controller.dart';
import 'package:simro/models/Enquete.dart';
import 'package:simro/models/Prix_Marche_Consommation.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/screens/prix_marche_consommation.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/Snackbar.dart';
import 'package:simro/widgets/loading_over_lay.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class AddPrixMarcheConsommationScreen extends StatefulWidget {
  bool? isEditMode;
  int? id_enquete;
  PrixMarcheConsommation? prixMarcheConsommation;
   AddPrixMarcheConsommationScreen({super.key, this.isEditMode, this.prixMarcheConsommation, this.id_enquete});

  @override
  State<AddPrixMarcheConsommationScreen> createState() => _AddPrixMarcheConsommationScreenState();
}

class _AddPrixMarcheConsommationScreenState extends State<AddPrixMarcheConsommationScreen> {

          final GlobalKey<FormState> formkey = GlobalKey<FormState>();

     late TextEditingController _searchController;

  TextEditingController uniteController = TextEditingController();
  TextEditingController enqueteController = TextEditingController();
  TextEditingController poidsUnitaireController = TextEditingController();
  TextEditingController prixParKilogrammeOuLitreController = TextEditingController();
  TextEditingController prixMesureController = TextEditingController();
  // TextEditingController documentController = TextEditingController();
  TextEditingController niveauApprovisionnementController = TextEditingController();
  // TextEditingController statutController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  TextEditingController produitController = TextEditingController();
  bool isLoading = true;

  //  late Enquete enquete;
  //   late Future _enqueteList;
    late Produit produit;
    late Future _produitList;

     LocalDatabaseService dbHelper = LocalDatabaseService();

// Vérifier la connectivité

 // Récupérer les produits depuis l'API et les synchroniser
   Future<void> fetchAndSyncProduits() async {
  final st = Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;

  if (st == true) {
    try {
      final response = await http.get(Uri.parse("$apiUrl/all-produits/"));

      if (response.statusCode == 200) {
        // final List<dynamic> responseData = json.decode(response.body);
            final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

        List<Produit> produits = responseData.map((e) => Produit.fromMap(e)).toList();

        // Supprimer les produits existants en local avant de les mettre à jour
        await dbHelper.deleteAllProduits();

        // Insérer les produits récupérés dans la base de données locale
        for (var produit in produits) {
          await dbHelper.insertProduit(produit);
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération des produits : $e");
    }
  }
  // Une fois la synchronisation terminée, on récupère tous les produits locaux
  _produitList = dbHelper.getAllProduits();
}




  void showProduit() async {
  final BuildContext context = this.context;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  if (mounted) setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher un produit',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            content: FutureBuilder(
              future: _produitList, // Utilisez la future contenant la liste des produits
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildShimmerSelectList();
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Erreur lors du chargement des données"),
                  );
                }

                if (snapshot.hasData) {
                  // Suppression du décodage utf8.decode() puisque snapshot.data est déjà une liste
                  List<Produit> typeListe = snapshot.data as List<Produit>;

                  if (typeListe.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(child: Text("Aucun produit trouvé")),
                    );
                  }

                  String searchText = _searchController.text.toLowerCase();
                  List<Produit> filteredSearch = typeListe
                      .where((type) => type.nom_produit!
                          .toLowerCase()
                          .contains(searchText))
                      .toList();

                  return isLoading
                      ? buildShimmerSelectList() // Ajoute l'effet shimmer pendant le chargement
                      : filteredSearch.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(child: Text("Aucun produit trouvé")),
                            )
                          : SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemCount: filteredSearch.length,
                                itemBuilder: (context, index) {
                                  final type = filteredSearch[index];
                                  final isSelected = produitController.text ==
                                      type.nom_produit!;

                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          type.nom_produit!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        trailing: isSelected
                                            ? const Icon(
                                                Icons.check_box_outlined,
                                                color: vert,
                                              )
                                            : null,
                                        onTap: () {
                                          setState(() {
                                            produit = type;
                                            produitController.text =
                                                type.nom_produit!;
                                          });
                                        },
                                      ),
                                      Divider(),
                                    ],
                                  );
                                },
                              ),
                            );
                }

                return const SizedBox(height: 8);
              },
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Annuler',
                  style: TextStyle(color: d_colorOr, fontSize: 16),
                ),
                onPressed: () {
                  _searchController.clear();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Valider',
                  style: TextStyle(color: d_colorOr, fontSize: 16),
                ),
                onPressed: () {
                  _searchController.clear();
                  print('Options sélectionnées : $produit');
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}


  //  Future<void> _fetchProduitList() async {
  //   // Ajoutez votre logique pour récupérer la liste des marchés ici
  //     _produitList =
  //       http.get(Uri.parse('$apiUrl/all-produits/'));
  // }

  // Future<void> _fetchEnqueteCollecteList() async {
  //   // Ajoutez votre logique pour récupérer la liste des marchés ici
  //   _enqueteList = http.get(Uri.parse('$apiUrl/all-enquete/'));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.isEditMode == true){
    uniteController.text = widget.prixMarcheConsommation!.unite != null ? widget.prixMarcheConsommation!.unite!.toString() : "0";
    enqueteController.text = widget.prixMarcheConsommation!.enquete != null ? widget.prixMarcheConsommation!.enquete!.toString() : "0";
    poidsUnitaireController.text = widget.prixMarcheConsommation!.poids_unitaire != null ? widget.prixMarcheConsommation!.poids_unitaire!.toString() : "0";
    prixParKilogrammeOuLitreController.text = widget.prixMarcheConsommation!.prix_kg_litre != null ? widget.prixMarcheConsommation!.prix_kg_litre!.toString() : "0";
    prixMesureController.text = widget.prixMarcheConsommation!.prix_mesure != null ? widget.prixMarcheConsommation!.prix_mesure!.toString() : "0";
    // documentController.text = widget.prixMarcheConsommation!.document != null ? widget.prixMarcheConsommation!.document!.toString() : " ";
    niveauApprovisionnementController.text = widget.prixMarcheConsommation!.niveau_approvisionement != null ? widget.prixMarcheConsommation!.niveau_approvisionement!.toString() : " ";
    produitController.text = widget.prixMarcheConsommation!.produit != null ? widget.prixMarcheConsommation!.produit!.toString() : " ";

    }

    _searchController = TextEditingController();
    
    //  fetchAndSyncEnquete().then((value) => {
    //   setState(() {
    //     isLoading = false;
    //   })
    //  });

    fetchAndSyncProduits().then((value) {
      setState(() {
        isLoading = false;
      });
    });


  
  }

//     void showEnquete() async {
//   final BuildContext context = this.context;

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 controller: _searchController,
//                 onChanged: (value) {
//                   if (mounted) setState(() {}); // Mise à jour de l'état lors de la recherche
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Rechercher une enquête',
//                   border: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.grey[300]!,
//                       width: 1,
//                     ),
//                   ),
//                   suffixIcon: const Icon(Icons.search),
//                 ),
//               ),
//             ),
//             content: FutureBuilder(
//               future: _enqueteList,
//               builder: (_, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return buildShimmerSelectList(); // Simule le chargement
//                 }

//                 if (snapshot.hasError) {
//                   return const Center(
//                     child: Text("Erreur lors du chargement des données"),
//                   );
//                 }

//                 if (snapshot.hasData) {
//           List<Enquete> typeListe = snapshot.data as List<Enquete>;
//                     if (typeListe.isEmpty) {
//                       return const Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Center(child: Text("Aucune enquête trouvée")),
//                       );
//                     }

//                     // Filtre les résultats en fonction de la recherche
//                     String searchText = _searchController.text.toLowerCase();
//                     List<Enquete> filteredSearch = typeListe
//                         .where((type) => type.id_enquete.toString()
//                             .toLowerCase()
//                             .contains(searchText))
//                         .toList();

//                     return filteredSearch.isEmpty
//                         ? const Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Center(child: Text("Aucun résultat trouvé")),
//                           )
//                         : SizedBox(
//                             width: double.maxFinite,
//                             child: ListView.builder(
//                               itemCount: filteredSearch.length,
//                               itemBuilder: (context, index) {
//                                 final type = filteredSearch[index];

//                                 // Comparer correctement les types : ici en convertissant `id_enquete` en String
//                                 final isSelected = enqueteController.text == type.id_enquete.toString();

//                                 return Column(
//                                   children: [
//                                     ListTile(
//                                       title: Text(
//                                         type.id_enquete.toString(),
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: isSelected
//                                               ? FontWeight.bold
//                                               : FontWeight.normal,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       trailing: isSelected
//                                           ? const Icon(
//                                               Icons.check_box_outlined,
//                                               color: Colors.green, // Assure que `vert` est bien défini, sinon utilise une couleur par défaut
//                                             )
//                                           : null,
//                                       onTap: () {
//                                         setState(() {
//                                           enquete = type;
//                                           enqueteController.text = type.id_enquete.toString(); // Met à jour le controller avec l'id sélectionné
//                                         });
//                                       },
//                                     ),
//                                     const Divider(),
//                                   ],
//                                 );
//                               },
//                             ),
//                           );
                  
//                 }

//                 return const SizedBox(height: 8); // Si aucune donnée n'est chargée
//               },
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text(
//                   'Annuler',
//                   style: TextStyle(color: Colors.orange, fontSize: 16),
//                 ),
//                 onPressed: () {
//                   _searchController.clear();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: const Text(
//                   'Valider',
//                   style: TextStyle(color: Colors.orange, fontSize: 16),
//                 ),
//                 onPressed: () {
//                   _searchController.clear();
//                   print('Options sélectionnées : $enquete');
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Ajouter Prix Marché Consommation', style: TextStyle(color: blanc, fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: vert,
                leading: IconButton(
              onPressed: () {
                Get.offAll( const HomeScreen(), transition: Transition.leftToRight);
              },
              icon: const Icon(Icons.arrow_back_ios, color: blanc)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Padding(
                            padding:  EdgeInsets.only(left: 10),
                            child: Text(
                              "Unité*",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: uniteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez l'unité",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez l'unité";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
                          ),
                        const  SizedBox(
                            height: 15,
                          ),
               const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Poids Unitaire *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: poidsUnitaireController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le poids unitaire",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids unitaire";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
                          ),
                        const  SizedBox(
                            height: 15,
                          ),
               const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Prix par kilogramme ou Litre *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: prixParKilogrammeOuLitreController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le prix par kilogramme ou litre",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le prix par kilogramme ou litre";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
                          ),
                        const  SizedBox(
                            height: 15,
                          ),
               const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Prix mesure *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: prixMesureController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le prix messure ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le prix messure";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
                          ),
              //           const  SizedBox(
              //               height: 15,
              //             ),
              
            
              //  const Padding(
              //               padding:  EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 "Document *",
              //                 style:
              //                     TextStyle(color: (Colors.black), fontSize: 18),
              //               ),
              //             ),
              //     TextFormField(
              //               controller: documentController,
              //               decoration: InputDecoration(
              //                 contentPadding: const EdgeInsets.symmetric(
              //                     vertical: 10, horizontal: 20),
              //                 hintText: "Choisir le document",
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //               ),
              //               keyboardType: TextInputType.text,
              //               validator: (val) {
              //                 if (val == null || val.isEmpty) {
              //                   return "Veillez choisir le document";
              //                 } else {
              //                   return null;
              //                 }
              //               },
              //               // onSaved: (val) => nomActeur = val!,
              //             ),
                          const  SizedBox(
                            height: 15,
                          ),
               const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Niveau d'approvisionnement *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: niveauApprovisionnementController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le niveau d'approvisionnement",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le niveau d'approvisionnement";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
                          ),
                          // const  SizedBox(
                          //   height: 15,
                          // ),
              //  const Padding(
              //               padding:  EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 "Statut *",
              //                 style:
              //                     TextStyle(color: (Colors.black), fontSize: 18),
              //               ),
              //             ),
              //     TextFormField(
              //               controller: statutController,
              //               decoration: InputDecoration(
              //                 contentPadding: const EdgeInsets.symmetric(
              //                     vertical: 10, horizontal: 20),
              //                 hintText: "Entrez le statut",
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //               ),
              //               keyboardType: TextInputType.text,
              //               validator: (val) {
              //                 if (val == null || val.isEmpty) {
              //                   return "Veillez entrez le statut";
              //                 } else {
              //                   return null;
              //                 }
              //               },
              //               // onSaved: (val) => nomActeur = val!,
              //             ),
                          const  SizedBox(
                            height: 15,
                          ),
              //  const Padding(
              //               padding:  EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 "Observation *",
              //                 style:
              //                     TextStyle(color: (Colors.black), fontSize: 18),
              //               ),
              //             ),
              //     TextFormField(
              //               controller: observationController,
              //               decoration: InputDecoration(
              //                 contentPadding: const EdgeInsets.symmetric(
              //                     vertical: 10, horizontal: 20),
              //                 hintText: "Entrez l'observation",
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //               ),
              //               keyboardType: TextInputType.text,
              //               validator: (val) {
              //                 if (val == null || val.isEmpty) {
              //                   return "Veillez entrez l'observation";
              //                 } else {
              //                   return null;
              //                 }
              //               },
              //               // onSaved: (val) => nomActeur = val!,
              //             ),
                        // const  SizedBox(
                        //     height: 15,
                        //   ),

                          //     const Padding(
                          //   padding:  EdgeInsets.only(left: 10.0),
                          //   child: Text(
                          //     "Marché *",
                          //     style:
                          //         TextStyle(color: (Colors.black), fontSize: 18),
                          //   ),
                          // ),
                          //  GestureDetector(
                          //    onTap: _showMarche,
                          //    child: TextFormField(
                          //      onTap: _showMarche,
                          //      controller: marcheController,
                          //      keyboardType: TextInputType.text,
                          //      decoration: InputDecoration(
                          //        suffixIcon: Icon(Icons.arrow_drop_down,
                          //            color: Colors.blueGrey[400]),
                          //        hintText: "Sélectionner un marché",
                          //        contentPadding: const EdgeInsets.symmetric(
                          //            vertical: 10, horizontal: 20),
                          //        border: OutlineInputBorder(
                          //          borderRadius: BorderRadius.circular(8),
                          //        ),
                          //      ),
                          //    ),
                          //  ),
                        // const  SizedBox(
                        //     height: 15,
                        //   ),

                              const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: showProduit,
                             child: TextFormField(
                               onTap: showProduit,
                               controller: produitController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner un produit ",
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10, horizontal: 20),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                               ),
                             ),
                           ),
                        // const  SizedBox(
                        //     height: 15,
                        //   ),

                        //       const Padding(
                        //     padding:  EdgeInsets.only(left: 10.0),
                        //     child: Text(
                        //       "Enquete *",
                        //       style:
                        //           TextStyle(color: (Colors.black), fontSize: 18),
                        //     ),
                        //   ),
                        //    GestureDetector(
                        //      onTap: showEnquete,
                        //      child: TextFormField(
                        //        onTap: showEnquete,
                        //        controller: enqueteController,
                        //        keyboardType: TextInputType.text,
                        //        decoration: InputDecoration(
                        //          suffixIcon: Icon(Icons.arrow_drop_down,
                        //              color: Colors.blueGrey[400]),
                        //          hintText: "Sélectionner un produit ",
                        //          contentPadding: const EdgeInsets.symmetric(
                        //              vertical: 10, horizontal: 20),
                        //          border: OutlineInputBorder(
                        //            borderRadius: BorderRadius.circular(8),
                        //          ),
                        //        ),
                        //      ),
                        //    ),
                       
                            
     const SizedBox(height: 20,),
     Center(
        child: SizedBox(
          width:double.infinity,
          child: ElevatedButton(
                            onPressed: () async {
                           final  enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);
  

      
                              if(widget.isEditMode == false && formkey.currentState!.validate()){
                                     showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
//  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
 final st =  Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
   if (st == false) {
   print("hors ligne");
  // Mobile network available.
    Snack.error(titre: "Alerte", message:"Vous êtes hors connexion");
    PrixMarcheConsommation prixMarcheConsommation = PrixMarcheConsommation(
              enquete: widget.id_enquete!,
                              produit: produit.nom_produit!, unite:int.parse(uniteController.text), 
                              prix_mesure: double.parse(prixMesureController.text),
                               poids_unitaire: double.parse(poidsUnitaireController.text), 
                               prix_kg_litre: double.parse(prixParKilogrammeOuLitreController.text), app_mobile: 1, 
                               niveau_approvisionement: int.parse(niveauApprovisionnementController.text), statut: 0,
                                 id_personnel:enqueteurProvider.enqueteur!.id_personnel!.toString(),
        isSynced: 0,
  );
    await LocalDatabaseService().insertPrixMarcheConsommation(prixMarcheConsommation).then((value) => {
        LocalDatabaseService().getAllPrixMarcheConsommation().then((prixMarcheConsommation) {
    setState(() {
      isLoading = false;
    });
  hideLoadingDialog(context);
  })
    });
  }
  // else{
  //     print("en ligne");

  //                            showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
  //                            PrixMarcheService().addPrixMarcheConsommation(
  //                             enquete: widget.id_enquete!,
  //                             produit: produit.nom_produit!, unite:int.parse(uniteController.text), 
  //                             prix_mesure: double.parse(prixMesureController.text),
  //                              poids_unitaire: double.parse(poidsUnitaireController.text), 
  //                              prix_kg_litre: double.parse(prixParKilogrammeOuLitreController.text), app_mobile: 1, 
  //                              niveau_approvisionement: int.parse(niveauApprovisionnementController.text), statut: 0,
  //                                id_personnel:enqueteurProvider.enqueteur!.id_personnel!).then((value) {
  //   hideLoadingDialog(context); // Cache le dialogue de chargement

  //   // Reviens à la page précédente
  //   Navigator.pop(context);
  // });
  //                             }  

                              }
  //                             else if(widget.isEditMode == true && formkey.currentState!.validate()){
  //                                     showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
  //                            PrixMarcheService().updatePrixMarcheConsommation(
  //                             id_fiche: widget.prixMarcheConsommation!.id_fiche!,
  //                             enquete: int.parse(enqueteController.text),
  //                             produit: produitController.text, unite:int.parse(uniteController.text), 
  //                             prix_mesure: double.parse(prixMesureController.text),
  //                              poids_unitaire: double.parse(poidsUnitaireController.text),  
  //                              prix_kg_litre: double.parse(prixParKilogrammeOuLitreController.text), app_mobile: 1, 
  //                              niveau_approvisionement: int.parse(niveauApprovisionnementController.text), statut: 0,
  //                                id_personnel:enqueteurProvider.enqueteur!.id_personnel!).then((value) {
  //   hideLoadingDialog(context); // Cache le dialogue de chargement

  //   // Reviens à la page précédente
  //   Navigator.pop(context);
  // });
  //                             }
                           
                            },
                            style: ElevatedButton.styleFrom(
                                     backgroundColor: vert,
                                     padding: EdgeInsets.symmetric(vertical: 14.0),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                   ),
                            child: Text(
                            widget.isEditMode! ? "Modifier" : "Enregistrer",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
        ),
      )
                           
              ],
            ),
          ),
        ),
      ),
    );
  }
}