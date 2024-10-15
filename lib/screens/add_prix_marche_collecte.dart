import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:simro/controller/network_controller.dart';
import 'package:simro/models/Commune.dart';
import 'package:simro/models/Enquete.dart';
import 'package:simro/models/Enquete_Collecte.dart';
import 'package:simro/models/Marche.dart';
import 'package:simro/models/Prix_Marche_Collecte.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/prix_marche_collecte.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/Snackbar.dart';
import 'package:simro/widgets/loading_over_lay.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class AddPrixMarcheCollecteScreen extends StatefulWidget {
   bool? isEditMode;
   int? id_enquete;
   PrixMarcheCollecte? prixMarcheColecte;
   AddPrixMarcheCollecteScreen({super.key, this.isEditMode, this.id_enquete, this.prixMarcheColecte});

  @override
  State<AddPrixMarcheCollecteScreen> createState() => _AddPrixMarcheCollecteScreenState();
}

class _AddPrixMarcheCollecteScreenState extends State<AddPrixMarcheCollecteScreen> {

        final GlobalKey<FormState> formkey = GlobalKey<FormState>();


  late TextEditingController _searchController;
  

  TextEditingController uniteController = TextEditingController();
  TextEditingController prixFgKgController = TextEditingController();
  TextEditingController poidsUnitaireController = TextEditingController();
  TextEditingController prixParKilogrammeController = TextEditingController();
  TextEditingController montantAchatController = TextEditingController();
  TextEditingController distanceOrigineMarcheController = TextEditingController();
  TextEditingController montantTransportController = TextEditingController();
  TextEditingController etatRouteController = TextEditingController();
  TextEditingController quantiteCollecteController = TextEditingController();
  TextEditingController clientPrincipalController = TextEditingController();
  TextEditingController frsPrincipalController = TextEditingController();
  TextEditingController niveauApprovisionnementController = TextEditingController();
  TextEditingController statutController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  // TextEditingController marcheController = TextEditingController();
  TextEditingController produitController = TextEditingController();
  TextEditingController localiteController = TextEditingController();
  TextEditingController enqueteController = TextEditingController();
  bool isLoading = true;
    //   late Marche marche;
    // late Future _marcheList;
      late Produit produit;
    late Future _produitList;
      late Commune commune;
    late Future _communeList;

   
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
                future: _produitList,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  buildShimmerSelectList();
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Erreur lors du chargement des données"),
                    );
                  }

                  if (snapshot.hasData) {
                List<Produit> typeListe = snapshot.data as List<Produit>;


                      if (typeListe.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child:
                              Center(child: Text("Aucun produit trouvé")),
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
                      ) : SizedBox(
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
                                      Divider()
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

  void showLocalite() async {
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
                    hintText: 'Rechercher une localité',
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
                future: _communeList,
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
              List<Commune> typeListe = snapshot.data as List<Commune>;


                      if (typeListe.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child:
                              Center(child: Text("Aucune localité trouvée")),
                        );
                      }

                      String searchText = _searchController.text.toLowerCase();
                      List<Commune> filteredSearch = typeListe
                          .where((type) => type.nom_commune!
                              .toLowerCase()
                              .contains(searchText))
                          .toList();

                      return  filteredSearch.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: Text("Aucune localité trouvée")),
                      ) : SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemCount: filteredSearch.length,
                                itemBuilder: (context, index) {
                                  final type = filteredSearch[index];
                                  final isSelected = localiteController.text ==
                                      type.nom_commune!;

                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          type.nom_commune!,
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
                                            commune = type;
                                            localiteController.text =
                                                type.nom_commune!;
                                          });
                                        },
                                      ),
                                      Divider()
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
                    print('Options sélectionnées : $commune');
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
   
     LocalDatabaseService dbHelper = LocalDatabaseService();

  
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


   Future<void> fetchAndSyncCommune() async {
  final st = Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;

  if (st == true) {
    try {
      final response = await http.get(Uri.parse("$apiUrl/all-commune/"));

      if (response.statusCode == 200) {
            final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        List<Commune> communes = responseData.map((e) => Commune.fromMap(e)).toList();

        // Supprimer les communes existants en local avant de les mettre à jour
        await dbHelper.deleteAllCommunes();

        // Insérer les communes récupérés dans la base de données locale
        for (var commune in communes) {
          await dbHelper.insertCommune(commune);
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération des communes : $e");
    }
  }
  // Une fois la synchronisation terminée, on récupère tous les communes locaux
     _communeList = dbHelper.getAllCommunes();
   }


   
   // Fonction pour récupérer la liste des marchés depuis l'API
  // Future<void> _fetchEnqueteCollecteList() async {
  //   // Ajoutez votre logique pour récupérer la liste des marchés ici
  //   _enqueteList = http.get(Uri.parse('$apiUrl/all-enquete-collecte/'));
  // }

  // Future<void> _fetchCommuneList() async {
  //   // Ajoutez votre logique pour récupérer la liste des marchés ici
  //   _communeList =
  //       http.get(Uri.parse('$apiUrl/all-commune/'));
  // }

  // Future<void> _fetchProduitList() async {
  //   // Ajoutez votre logique pour récupérer la liste des marchés ici
  //     _produitList =
  //       http.get(Uri.parse('$apiUrl/all-produits/'));
  // }




  @override
  void initState() {
    super.initState();
    if(widget.isEditMode == true){
      enqueteController.text = widget.prixMarcheColecte!.enquete != null ? widget.prixMarcheColecte!.enquete!.toString() : "0";
      uniteController.text = widget.prixMarcheColecte!.unite != null ? widget.prixMarcheColecte!.unite!.toString() : "0";
      poidsUnitaireController.text = widget.prixMarcheColecte!.poids_unitaire != null ? widget.prixMarcheColecte!.poids_unitaire!.toString() : "0";
      prixParKilogrammeController.text = widget.prixMarcheColecte!.prix_fg_kg != null ? widget.prixMarcheColecte!.prix_fg_kg!.toString() : "0";
      montantAchatController.text = widget.prixMarcheColecte!.montant_achat != null ? widget.prixMarcheColecte!.montant_achat!.toString() : "0";
      distanceOrigineMarcheController.text = widget.prixMarcheColecte!.distance_origine_marche != null ? widget.prixMarcheColecte!.distance_origine_marche!.toString() : "0";
      montantTransportController.text = widget.prixMarcheColecte!.montant_transport != null ? widget.prixMarcheColecte!.montant_transport!.toString() : "0";
      etatRouteController.text = widget.prixMarcheColecte!.etat_route != null ? widget.prixMarcheColecte!.etat_route!.toString() : "0";
      quantiteCollecteController.text = widget.prixMarcheColecte!.quantite_collecte != null ? widget.prixMarcheColecte!.quantite_collecte!.toString() : "0";
      clientPrincipalController.text = widget.prixMarcheColecte!.client_principal != null ? widget.prixMarcheColecte!.client_principal!.toString() : "0";
      frsPrincipalController.text = widget.prixMarcheColecte!.fournisseur_principal != null ? widget.prixMarcheColecte!.fournisseur_principal!.toString() : "0";
      niveauApprovisionnementController.text = widget.prixMarcheColecte!.niveau_approvisionement != null ? widget.prixMarcheColecte!.niveau_approvisionement!.toString() : "0";
      produitController.text = widget.prixMarcheColecte!.produit != null ? widget.prixMarcheColecte!.produit!.toString() : "";
      produitController.text = widget.prixMarcheColecte!.produit != null ? widget.prixMarcheColecte!.produit!.toString() : "";
      localiteController.text = widget.prixMarcheColecte!.localite_origine != null ? widget.prixMarcheColecte!.localite_origine!.toString() : "";
    
    }
       _searchController = TextEditingController();
        // _marcheList =
        // http.get(Uri.parse('$apiUrl/all-marche/'));


     fetchAndSyncProduits().then((value) => {
      setState(() {
        isLoading = false;
      })
     });

     fetchAndSyncCommune().then((value) => {
      setState(() {
        isLoading = false;
      })
     });
     print(widget.id_enquete);

  

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text('${widget.isEditMode! ? "Modifier" : "Ajouter"} Prix Marché Collecte', style:const TextStyle(color: blanc, fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: vert,
                leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                              "Prix par kilogramme *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: prixParKilogrammeController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le prix par kilogramme",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le prix par kilogramme";
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
                              "Montant achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: montantAchatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le montant d'achat",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le montant d'achat";
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
                              "Distance d'origine du marché *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: distanceOrigineMarcheController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez la distance d'origine du marché",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez la distance d'origine du marché";
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
                              "Montant du transport *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: montantTransportController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le montant du transport *",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le montant du transport ";
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
                              "etat de la route *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: etatRouteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez l'etat de la route",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez l'etat de la route";
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
                              "Quantité collecte *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: quantiteCollecteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez la quantité collecte",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez la quantite collecte";
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
                              "Client principal *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: clientPrincipalController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le client principal",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le client principal";
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
                              "Fournisseur principal *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: frsPrincipalController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le fournisseur principal",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le fournisseur principal";
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
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le niveau d'approvisionnement";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
                          ),
                        
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
              //             const  SizedBox(
              //               height: 15,
              //             ),
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

                        //       const Padding(
                        //     padding:  EdgeInsets.only(left: 10.0),
                        //     child: Text(
                        //       "Marché *",
                        //       style:
                        //           TextStyle(color: (Colors.black), fontSize: 18),
                        //     ),
                        //   ),
                        //    GestureDetector(
                        //      onTap: showMarche,
                        //      child: TextFormField(
                        //        onTap: showMarche,
                        //        controller: marcheController,
                        //        keyboardType: TextInputType.text,
                        //        decoration: InputDecoration(
                        //          suffixIcon: Icon(Icons.arrow_drop_down,
                        //              color: Colors.blueGrey[400]),
                        //          hintText: "Sélectionner un marché",
                        //          contentPadding: const EdgeInsets.symmetric(
                        //              vertical: 10, horizontal: 20),
                        //          border: OutlineInputBorder(
                        //            borderRadius: BorderRadius.circular(8),
                        //          ),
                        //        ),
                        //      ),
                        //    ),
                      
                        const  SizedBox(
                            height: 15,
                          ),

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
                        const  SizedBox(
                            height: 15,
                          ),

                              const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Localité *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: showLocalite,
                             child: TextFormField(
                               onTap: showLocalite,
                               controller: localiteController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner une localité",
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10, horizontal: 20),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                               ),
                             ),
                           ),
     const SizedBox(height: 20,),
   Center(
        child: SizedBox(
          width:double.infinity,
          child: ElevatedButton(
                            onPressed: () async {
                                   final  enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);

                              if(formkey.currentState!.validate() && widget.isEditMode == false){
//  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
 final st =  Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
   if (st == false) {
   print("hors ligne");
  // Mobile network available.
    Snack.error(titre: "Alerte", message:"Vous êtes hors connexion");
    PrixMarcheCollecte prixMarcheCollecte = PrixMarcheCollecte(
    enquete: widget.id_enquete!,
                              produit: produit.nom_produit.toString(), unite: int.parse(uniteController.text), 
                              poids_unitaire: double.parse(poidsUnitaireController.text), 
                              montant_achat: double.parse(montantAchatController.text),
                              prix_fg_kg: double.parse(prixParKilogrammeController.text), 
                              distance_origine_marche: double.parse(distanceOrigineMarcheController.text),
                               montant_transport: int.parse(montantTransportController.text),
                                app_mobile:1,
                                 quantite_collecte: double.parse(quantiteCollecteController.text),
                                 client_principal: int.parse(clientPrincipalController.text), 
                                 fournisseur_principal: int.parse(frsPrincipalController.text),
                                 niveau_approvisionement: int.parse(niveauApprovisionnementController.text), statut: 0,
                                  localite_origine: commune.id_commune!.toString(), 
                                  etat_route: etatRouteController.text,
                                  //  observation: observationController.text, 
                                    id_personnel: enqueteurProvider.enqueteur!.id_personnel!,
    isSynced: 0,
  );
                                    showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
    await LocalDatabaseService().insertPrixMarcheCollecte(prixMarcheCollecte).then((value) => {
        LocalDatabaseService().getAllPrixMarcheCollecte().then((prixMarcheCollecte) {
    setState(() {
      isLoading = false;
    });
  hideLoadingDialog(context);
  })
    });
  }
                                    }
  //                                   else if(formkey.currentState!.validate() && widget.isEditMode == true){
  //                                showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement

  //                           await PrixMarcheService().updatePrixMarcheCollecte(
  //                             modifier_par: "${enqueteurProvider.enqueteur!.nom!}  ${enqueteurProvider.enqueteur!.prenom!}" ,
  //                             id_fiche: widget.prixMarcheColecte!.id_fiche!,
  //                            enquete: int.parse(enqueteController.text),
  //                             produit: produitController.text, unite: int.parse(uniteController.text), 
  //                             poids_unitaire: double.parse(poidsUnitaireController.text), 
  //                             montant_achat: double.parse(montantAchatController.text),
  //                             prix_fg_kg: double.parse(prixParKilogrammeController.text), 
  //                             distance_origine_marche: double.parse(distanceOrigineMarcheController.text),
  //                              montant_transport: int.parse(montantTransportController.text),
  //                               app_mobile:1,
  //                                quantite_collecte: double.parse(quantiteCollecteController.text),
  //                                client_principal: int.parse(clientPrincipalController.text), 
  //                                fournisseur_principal: int.parse(frsPrincipalController.text),
  //                                niveau_approvisionement: int.parse(niveauApprovisionnementController.text), statut: 0,
  //                                 localite_origine: localiteController.text, 
  //                                 etat_route: etatRouteController.text,
  //                                 //  observation: observationController.text, 
  //                                   id_personnel: enqueteurProvider.enqueteur!.id_personnel!
  //                                   ).then((value) {
  //   hideLoadingDialog(context); // Cache le dialogue de chargement

  //   // Reviens à la page précédente
  //   Navigator.pop(context);
  // });

  //                                   }
                              // Get.to(PrixMarcheCollecteScreen() , transition: Transition.rightToLeft, duration: Duration(seconds: 2));
                            
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