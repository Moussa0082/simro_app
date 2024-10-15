import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/controller/network_controller.dart';
import 'package:simro/models/Commune.dart';
import 'package:simro/models/Enquete_Grossiste.dart';
import 'package:simro/models/Prix_Marche_Grossiste.dart';
import 'package:simro/models/Produit.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/screens/prix_marche_grossiste.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/Snackbar.dart';
import 'package:simro/widgets/loading_over_lay.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class AddPrixMarcheGrossisteScreen extends StatefulWidget {
   bool? isEditMode;
   PrixMarcheGrossiste? prixMarcheGrossiste;
   int? id_enquete;
   AddPrixMarcheGrossisteScreen({super.key, this.isEditMode, this.prixMarcheGrossiste, this.id_enquete});

  @override
  State<AddPrixMarcheGrossisteScreen> createState() => _AddPrixMarcheGrossisteScreenState();
}

class _AddPrixMarcheGrossisteScreenState extends State<AddPrixMarcheGrossisteScreen> {
 
         final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late TextEditingController _searchController;

  TextEditingController uniteStockController = TextEditingController();
  TextEditingController nbreUniteStockController = TextEditingController();
  TextEditingController poidsMoyenUniteStockController = TextEditingController();
  TextEditingController poidsEnStockController = TextEditingController();
  TextEditingController uniteAchatController = TextEditingController();
  TextEditingController nbreUniteAchatController = TextEditingController();
  TextEditingController poidsMoyenUniteAchatController = TextEditingController();
  TextEditingController poidsTotalAchatController = TextEditingController();
  TextEditingController localiteAchatController = TextEditingController();
  TextEditingController frsAchatController = TextEditingController();
  TextEditingController uniteVenteController = TextEditingController();
  TextEditingController nbreUniteVenteController = TextEditingController();
  TextEditingController poidsMoyenUniteVenteController = TextEditingController();
  TextEditingController poidsTotalUniteVenteController = TextEditingController();
  TextEditingController prixUnitaireVenteController = TextEditingController();
  TextEditingController clientVenteController = TextEditingController();
  TextEditingController localiteVenteController = TextEditingController();
  TextEditingController enqueteController = TextEditingController();
  TextEditingController niveauApprovisionnementController = TextEditingController();
  // TextEditingController localiteController = TextEditingController();
  TextEditingController produitController = TextEditingController();
  TextEditingController grossiteController = TextEditingController();
  bool isLoading = true;
      late Commune commune;
      late Produit produit;
    late Future _produitList;
      late Commune commune1;
    late Future _communeList;
    //   late EnqueteGrossiste enquete;
    // late Future _enqueteList;

   

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
                                  final isSelected = localiteVenteController.text ==
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
                                            localiteVenteController.text =
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


   void showLocaliteAchat() async {
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
                              Center(child: Text("Aucun commune trouvée")),
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
                                  final isSelected = localiteAchatController.text ==
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
                                            commune1 = type;
                                            localiteAchatController.text =
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
                    print('Options sélectionnées : $commune1');
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


   
  //   Future<void> _fetchEnqueteGrossisteList() async {
  //   _enqueteList = http.get(Uri.parse('$apiUrl/all-enquete-grossiste/'));
  // }

  //   Future<void> _fetchProduitList() async {
  //   _produitList = http.get(Uri.parse('$apiUrl/all-produits/'));
  // }


  //   Future<void> _fetchCommuneList() async {
  //   _communeList =
  //       http.get(Uri.parse('$apiUrl/all-commune/'));
  //   }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
   fetchAndSyncCommune().then((value) => {
      setState(() {
        isLoading = false;
      })
     });
     
   fetchAndSyncProduits().then((value) => {
      setState(() {
        isLoading = false;
      })
     });



     if(widget.isEditMode == true){
      localiteVenteController.text = widget.prixMarcheGrossiste!.localite_vente != null ? widget.prixMarcheGrossiste!.localite_vente!.toString() : "";
      enqueteController.text = widget.prixMarcheGrossiste!.enquete != null ? widget.prixMarcheGrossiste!.enquete!.toString() : "";
      uniteStockController.text = widget.prixMarcheGrossiste!.unite_stock != null ? widget.prixMarcheGrossiste!.unite_stock!.toString() : "0";
      nbreUniteStockController.text = widget.prixMarcheGrossiste!.nombre_unite_stock != null ? widget.prixMarcheGrossiste!.nombre_unite_stock!.toString() : "0";
      poidsMoyenUniteStockController.text = widget.prixMarcheGrossiste!.poids_moyen_unite_stock != null ? widget.prixMarcheGrossiste!.poids_moyen_unite_stock!.toString() : "0";
      produitController.text = widget.prixMarcheGrossiste!.produit != null ? widget.prixMarcheGrossiste!.produit!.toString() : " ";
      poidsEnStockController.text = widget.prixMarcheGrossiste!.poids_stock != null ? widget.prixMarcheGrossiste!.poids_stock!.toString() : " 0";
      uniteAchatController.text = widget.prixMarcheGrossiste!.unite_achat != null ? widget.prixMarcheGrossiste!.unite_achat!.toString() : " 0";
      nbreUniteAchatController.text = widget.prixMarcheGrossiste!.nombre_unite_achat != null ? widget.prixMarcheGrossiste!.nombre_unite_achat!.toString() : " 0";
      poidsMoyenUniteAchatController.text = widget.prixMarcheGrossiste!.poids_moyen_unite_achat != null ? widget.prixMarcheGrossiste!.poids_moyen_unite_achat!.toString() : " 0";
      poidsTotalAchatController.text = widget.prixMarcheGrossiste!.poids_total_achat != null ? widget.prixMarcheGrossiste!.poids_total_achat!.toString() : " 0";
      localiteAchatController.text = widget.prixMarcheGrossiste!.localite_achat != null ? widget.prixMarcheGrossiste!.localite_achat!.toString() : " 0";
      frsAchatController.text = widget.prixMarcheGrossiste!.fournisseur_achat != null ? widget.prixMarcheGrossiste!.fournisseur_achat!.toString() : " 0";
      uniteVenteController.text = widget.prixMarcheGrossiste!.unite_vente != null ? widget.prixMarcheGrossiste!.unite_vente!.toString() : " 0";
      nbreUniteVenteController.text = widget.prixMarcheGrossiste!.nombre_unite_vente != null ? widget.prixMarcheGrossiste!.nombre_unite_vente!.toString() : " 0";
      poidsMoyenUniteVenteController.text = widget.prixMarcheGrossiste!.poids_moyen_unite_vente != null ? widget.prixMarcheGrossiste!.poids_moyen_unite_vente!.toString() : " 0";
      poidsTotalUniteVenteController.text = widget.prixMarcheGrossiste!.poids_total_unite_vente != null ? widget.prixMarcheGrossiste!.poids_total_unite_vente!.toString() : " 0";
      prixUnitaireVenteController.text = widget.prixMarcheGrossiste!.prix_unitaire_vente != null ? widget.prixMarcheGrossiste!.prix_unitaire_vente!.toString() : " 0";
      clientVenteController.text = widget.prixMarcheGrossiste!.client_vente != null ? widget.prixMarcheGrossiste!.client_vente!.toString() : " ";
      localiteVenteController.text = widget.prixMarcheGrossiste!.localite_vente != null ? widget.prixMarcheGrossiste!.localite_vente!.toString() : " ";
      
    }
    _searchController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Ajouter Prix Marché Grossiste', style: TextStyle(color: blanc, fontSize: 20, fontWeight: FontWeight.bold),),
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
                              "Unité de stock*",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: uniteStockController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez l'unité de stock",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez l'unité de stock";
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
                              "Nombre d'unité en stock *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: nbreUniteStockController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le nombre d'unité en stock",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le nombre d'unité en stock";
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
                              "Poids moyen unité stock *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: poidsMoyenUniteStockController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le moyen unité stock",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le moyen unité stock";
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
                              "Poids en stock *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: poidsEnStockController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le poids en stock",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids en stock";
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
                              "Unité d'achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: uniteAchatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez l'unité d'achat *",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez l'unité d'achat";
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
                              "Nombre d'unité d'achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: nbreUniteAchatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le nombre d'unité d'achat *",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le nombre d'unité d'achat ";
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
                              "Poids moyen unité d'achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: poidsMoyenUniteAchatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le poids moyen d'unité d'achat",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids moyen d'unité d'achat";
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
                              "Poids total d'achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: poidsTotalAchatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le poids total d'achat",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids total d'achat";
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
                              "Fournisseur d'achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: frsAchatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le fournisseur d'achat",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le fournisseur d'achat";
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
                              "Unité de vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: uniteVenteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez l'unité de vente",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez l'unité de vente";
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
                              "Nombre unité de vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                   TextFormField(
                            controller: nbreUniteVenteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez nombre d'unité de vente",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez nombre d'unité de vente";
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
                              "Poids moyen unité de vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                   TextFormField(
                            controller: poidsMoyenUniteVenteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le poids moyen d'unité de vente",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids moyen d'unité de vente";
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
                              "Poids total unité de vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                   TextFormField(
                            controller: poidsTotalUniteVenteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le poids total d'unité de vente",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids total d'unité de vente";
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
                              "Prix unitaire de vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                   TextFormField(
                            controller: prixUnitaireVenteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le prix unitaire de vente",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le prix unitaire de vente";
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
                              "Client de la vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                   TextFormField(
                            controller: clientVenteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le client de la vente",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le client de la vente";
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
                              "Localité de la vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                               GestureDetector(
                             onTap: showLocalite,
                             child: TextFormField(
                               onTap: showLocalite,
                               controller: localiteVenteController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner une localite ",
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
                              "Localité achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                               GestureDetector(
                             onTap: showLocaliteAchat,
                             child: TextFormField(
                               onTap: showLocaliteAchat,
                               controller: localiteAchatController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner une localite ",
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10, horizontal: 20),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                               ),
                             ),
                           ),
           
              //             const  SizedBox(
              //               height: 15,
              //             ),
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

                          //     const Padding(
                          //   padding:  EdgeInsets.only(left: 10.0),
                          //   child: Text(
                          //     "Enquete *",
                          //     style:
                          //         TextStyle(color: (Colors.black), fontSize: 18),
                          //   ),
                          // ),
                          //  GestureDetector(
                          //    onTap: showEnquete,
                          //    child: TextFormField(
                          //      onTap: showEnquete,
                          //      controller: enqueteController,
                          //      keyboardType: TextInputType.text,
                          //      decoration: InputDecoration(
                          //        suffixIcon: Icon(Icons.arrow_drop_down,
                          //            color: Colors.blueGrey[400]),
                          //        hintText: "Sélectionner un enquete ",
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

                        //       const Padding(
                        //     padding:  EdgeInsets.only(left: 10.0),
                        //     child: Text(
                        //       "Grossiste *",
                        //       style:
                        //           TextStyle(color: (Colors.black), fontSize: 18),
                        //     ),
                        //   ),
                        //    GestureDetector(
                        //      onTap: null,
                        //      child: TextFormField(
                        //        onTap: null,
                        //        controller: grossiteController,
                        //        keyboardType: TextInputType.text,
                        //        decoration: InputDecoration(
                        //          suffixIcon: Icon(Icons.arrow_drop_down,
                        //              color: Colors.blueGrey[400]),
                        //          hintText: "Sélectionner un grossiste",
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
//  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
 final st =  Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
   if (st == false) {
                                 showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
   print("hors ligne");
  // Mobile network available.
    Snack.error(titre: "Alerte", message:"Vous êtes hors connexion");
    PrixMarcheGrossiste prixMarcheGrossiste = PrixMarcheGrossiste(
    enquete: widget.id_enquete!, localite_vente:commune1.id_commune!.toString(),
                                produit: produit.nom_produit!, unite_stock: int.parse(uniteStockController.text), 
                                poids_moyen_unite_stock: double.parse(poidsMoyenUniteStockController.text), nombre_unite_stock: double.parse(nbreUniteStockController.text),
                                 poids_stock: double.parse(poidsEnStockController.text),  nombre_unite_achat: double.parse(nbreUniteAchatController.text),
                                  unite_achat: int.parse(uniteAchatController.text), poids_moyen_unite_achat: double.parse(poidsMoyenUniteAchatController.text), 
                                  poids_total_achat: double.parse(poidsTotalAchatController.text), app_mobile: 1, fournisseur_achat: int.parse(uniteAchatController.text),
                                   localite_achat: commune.id_commune!.toString(), nombre_unite_vente: double.parse(nbreUniteVenteController.text),
                                 unite_vente:int.parse(uniteVenteController.text) ,
                                client_vente:int.parse(clientVenteController.text) ,
                                   statut: 0, poids_moyen_unite_vente: double.parse(poidsMoyenUniteVenteController.text),
                                    poids_total_unite_vente: double.parse(poidsTotalUniteVenteController.text), 
                                     prix_unitaire_vente: double.parse(prixUnitaireVenteController.text),
                                     id_personnel: enqueteurProvider.enqueteur!.id_personnel!,
        isSynced: 0,
  );
    await LocalDatabaseService().insertPrixMarcheGrossiste(prixMarcheGrossiste).then((value) => {
        LocalDatabaseService().getAllPrixMarcheGrossiste().then((value) {
    setState(() {
      isLoading = false;
    });
  })
    });
  hideLoadingDialog(context);
  }
  // else{
  //     print("en ligne");

                            
  //                              showLoadingDialog(context, "Veuillez patienter");
  //                              await PrixMarcheService().addPrixMarcheGrossiste(
  //                               enquete: enquete.id_enquete!, localite_vente:commune1.id_commune!.toString(),
  //                               produit: produit.nom_produit!, unite_stock: int.parse(uniteStockController.text), 
  //                               poids_moyen_unite_stock: double.parse(poidsMoyenUniteStockController.text), nombre_unite_stock: double.parse(nbreUniteStockController.text),
  //                                poids_stock: double.parse(poidsEnStockController.text),  nombre_unite_achat: double.parse(nbreUniteAchatController.text),
  //                                 unite_achat: int.parse(uniteAchatController.text), poids_moyen_unite_achat: double.parse(poidsMoyenUniteAchatController.text), 
  //                                 poids_total_achat: double.parse(poidsTotalAchatController.text), app_mobile: 1, fournisseur_achat: int.parse(uniteAchatController.text),
  //                                  localite_achat: commune.id_commune!.toString(), nombre_unite_vente: double.parse(nbreUniteVenteController.text),
  //                                unite_vente:int.parse(uniteVenteController.text) ,
  //                               client_vente:int.parse(clientVenteController.text) ,
  //                                  statut: 0, poids_moyen_unite_vente: double.parse(poidsMoyenUniteVenteController.text),
  //                                   poids_total_unite_vente: double.parse(poidsTotalUniteVenteController.text),  prix_unitaire_vente: double.parse(prixUnitaireVenteController.text), id_personnel: enqueteurProvider.enqueteur!.id_personnel!).then((value) {
  //   hideLoadingDialog(context); // Cache le dialogue de chargement

  //   // Reviens à la page précédente
  //   Navigator.pop(context);
  // });
  
  //                             }
                              }
                              
  //                             else if(widget.isEditMode == true && formkey.currentState!.validate()) {
  //                              showLoadingDialog(context, "Veuillez patienter");
  //                             await PrixMarcheService().updatePrixMarcheGrossiste(
  //                               unite_vente:int.parse(uniteVenteController.text) ,
  //                               client_vente:int.parse(clientVenteController.text) ,
  //                               enquete: int.parse(enqueteController.text),
  //                              id_fiche: widget.prixMarcheGrossiste!.id_fiche!,
  //                              localite_vente: localiteVenteController.text,
  //                               produit: produitController.text, unite_stock: int.parse(uniteStockController.text), 
  //                               poids_moyen_unite_stock: double.parse(poidsMoyenUniteStockController.text), nombre_unite_stock: double.parse(nbreUniteStockController.text),
  //                                poids_stock: double.parse(poidsEnStockController.text),  nombre_unite_achat: double.parse(nbreUniteAchatController.text),
  //                                 unite_achat: int.parse(uniteAchatController.text), poids_moyen_unite_achat: double.parse(poidsMoyenUniteAchatController.text), 
  //                                 poids_total_achat: double.parse(poidsTotalAchatController.text), app_mobile: 1, fournisseur_achat: int.parse(uniteAchatController.text),
  //                                  localite_achat: localiteAchatController.text, nombre_unite_vente: double.parse(nbreUniteVenteController.text),
  //                                   statut: 0, poids_moyen_unite_vente: double.parse(poidsMoyenUniteVenteController.text),
  //                                   poids_total_unite_vente: double.parse(poidsTotalUniteVenteController.text),  prix_unitaire_vente: double.parse(prixUnitaireVenteController.text), id_personnel: enqueteurProvider.enqueteur!.id_personnel!)  .then((value) {
  //   hideLoadingDialog(context); // Cache le dialogue de chargement

  //   // Reviens à la page précédente
  //   Navigator.pop(context);
  // });}
                           
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