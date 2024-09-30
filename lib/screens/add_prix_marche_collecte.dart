import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/prix_marche_collecte.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class AddPrixMarcheCollecteScreen extends StatefulWidget {
  const AddPrixMarcheCollecteScreen({super.key});

  @override
  State<AddPrixMarcheCollecteScreen> createState() => _AddPrixMarcheCollecteScreenState();
}

class _AddPrixMarcheCollecteScreenState extends State<AddPrixMarcheCollecteScreen> {

  late TextEditingController _searchController;

  TextEditingController uniteController = TextEditingController();
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
  TextEditingController marcheController = TextEditingController();
  TextEditingController produitController = TextEditingController();
  TextEditingController localiteController = TextEditingController();
  bool isLoading = true;

   
  void _showMarche() {
  final BuildContext context = this.context;
  final TextEditingController _searchController = TextEditingController();
  List<String> marcheList = [
    'Marché Central',
    'Marché Local',
    'Marché Virtuel',
    'Marché International',
  ];
  List<String> filteredList = marcheList;
  

  // Simuler un délai de 4 secondes avant de charger les données
  Timer(const Duration(seconds: 4), () {
    isLoading = false;
    if (context.mounted) setState(() {});
  });

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
                  if (mounted) {
                    setState(() {
                      filteredList = marcheList
                          .where((marche) => marche
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher un marché',
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
            content: isLoading
                ? buildShimmerSelectList() // Ajoute l'effet shimmer pendant le chargement
                : filteredList.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: Text("Aucun marché trouvé")),
                      )
                    : SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final marche = filteredList[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    marche,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      print('Marché sélectionné: $marche');
                                    });
                                  },
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        ),
                      ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Annuler',
                  style: TextStyle(color: Colors.orange, fontSize: 16),
                ),
                onPressed: () {
                  _searchController.clear();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Valider',
                  style: TextStyle(color: vert, fontSize: 16),
                ),
                onPressed: () {
                  _searchController.clear();
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



  //  void _showCategorie() async {
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
  //                   if (mounted) setState(() {});
  //                 },
  //                 decoration: InputDecoration(
  //                   hintText: 'Rechercher une categorie',
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
  //               future: _categorieList,
  //               builder: (_, snapshot) {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return const Center(child: CircularProgressIndicator());
  //                 }

  //                 if (snapshot.hasError) {
  //                   return const Center(
  //                     child: Text("Erreur lors du chargement des données"),
  //                   );
  //                 }

  //                 if (snapshot.hasData) {
  //                   final responseData =
  //                       json.decode(utf8.decode(snapshot.data.bodyBytes));
  //                   if (responseData is List) {
  //                     List<CategorieProduit> typeListe = responseData
  //                         .map((e) => CategorieProduit.fromMap(e))
  //                         .where((con) => con.statutCategorie == true)
  //                         .toList();

  //                     if (typeListe.isEmpty) {
  //                       return const Padding(
  //                         padding: EdgeInsets.all(10),
  //                         child:
  //                             Center(child: Text("Aucune categorie trouvée")),
  //                       );
  //                     }

  //                     String searchText = _searchController.text.toLowerCase();
  //                     List<CategorieProduit> filteredSearch = typeListe
  //                         .where((type) => type.libelleCategorie!
  //                             .toLowerCase()
  //                             .contains(searchText))
  //                         .toList();

  //                     return filteredSearch.isEmpty
  //                         ? const Text(
  //                             'Aucune categorie trouvée',
  //                             style:
  //                                 TextStyle(color: Colors.black, fontSize: 17),
  //                           )
  //                         : SizedBox(
  //                             width: double.maxFinite,
  //                             child: ListView.builder(
  //                               itemCount: filteredSearch.length,
  //                               itemBuilder: (context, index) {
  //                                 final type = filteredSearch[index];
  //                                 final isSelected = catController.text ==
  //                                     type.libelleCategorie;

  //                                 return Column(
  //                                   children: [
  //                                     ListTile(
  //                                       title: Text(
  //                                         type.libelleCategorie!,
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
  //                                               color: d_colorOr,
  //                                             )
  //                                           : null,
  //                                       onTap: () {
  //                                         setState(() {
  //                                           categorieProduit = type;
  //                                           catController.text =
  //                                               type.libelleCategorie!;
  //                                         });
  //                                       },
  //                                     ),
  //                                     Divider()
  //                                   ],
  //                                 );
  //                               },
  //                             ),
  //                           );
  //                   }
  //                 }

  //                 return const SizedBox(height: 8);
  //               },
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: const Text(
  //                   'Annuler',
  //                   style: TextStyle(color: d_colorOr, fontSize: 16),
  //                 ),
  //                 onPressed: () {
  //                   _searchController.clear();
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               TextButton(
  //                 child: const Text(
  //                   'Valider',
  //                   style: TextStyle(color: vert, fontSize: 16),
  //                 ),
  //                 onPressed: () {
  //                   _searchController.clear();
  //                   print('Options sélectionnées : $categorieProduit');
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Ajouter Prix Marché Collecte', style: TextStyle(color: blanc, fontSize: 20, fontWeight: FontWeight.bold),),
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
                          const  SizedBox(
                            height: 15,
                          ),
               const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Statut *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: statutController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le statut",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le statut";
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
                              "Observation *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: observationController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez l'observation",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez l'observation";
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
                              "Marché *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: _showMarche,
                             child: TextFormField(
                               onTap: _showMarche,
                               controller: marcheController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner un marché",
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
                              "Produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: _showMarche,
                             child: TextFormField(
                               onTap: _showMarche,
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
                             onTap: _showMarche,
                             child: TextFormField(
                               onTap: _showMarche,
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
                              Get.to(PrixMarcheCollecteScreen() , transition: Transition.rightToLeft, duration: Duration(seconds: 2));
                             ScaffoldMessenger.of(context).showSnackBar(
                                                                              const SnackBar(
                                                                                content: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text("Ajouté avec succès"),
                                                                                  ],
                                                                                ),
                                                                                duration: Duration(seconds: 2),
                                                                              ),
                                                                            );
                            },
                            style: ElevatedButton.styleFrom(
                                     backgroundColor: vert,
                                     padding: EdgeInsets.symmetric(vertical: 14.0),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                   ),
                            child: Text(
                              "Enregistrer",
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