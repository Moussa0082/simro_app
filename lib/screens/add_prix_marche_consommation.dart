import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Prix_Marche_Consommation.dart';
import 'package:simro/screens/prix_marche_consommation.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class AddPrixMarcheConsommationScreen extends StatefulWidget {
  bool? isEditMode;
  PrixMarcheConsommation? prixMarcheConsommation;
   AddPrixMarcheConsommationScreen({super.key, this.isEditMode, this.prixMarcheConsommation});

  @override
  State<AddPrixMarcheConsommationScreen> createState() => _AddPrixMarcheConsommationScreenState();
}

class _AddPrixMarcheConsommationScreenState extends State<AddPrixMarcheConsommationScreen> {


     late TextEditingController _searchController;

  TextEditingController uniteController = TextEditingController();
  TextEditingController enqueteController = TextEditingController();
  TextEditingController poidsUnitaireController = TextEditingController();
  TextEditingController prixParKilogrammeOuLitreController = TextEditingController();
  TextEditingController uniteMesurePrixController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  TextEditingController niveauApprovisionnementController = TextEditingController();
  // TextEditingController statutController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  TextEditingController produitController = TextEditingController();
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




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.isEditMode == true){
    uniteController.text = widget.prixMarcheConsommation!.unite != null ? widget.prixMarcheConsommation!.unite!.toString() : "0";
    enqueteController.text = widget.prixMarcheConsommation!.enquete != null ? widget.prixMarcheConsommation!.enquete!.toString() : "0";
    poidsUnitaireController.text = widget.prixMarcheConsommation!.poids_unitaire != null ? widget.prixMarcheConsommation!.poids_unitaire!.toString() : "0";
    prixParKilogrammeOuLitreController.text = widget.prixMarcheConsommation!.prix_kg_litre != null ? widget.prixMarcheConsommation!.prix_kg_litre!.toString() : "0";
    uniteMesurePrixController.text = widget.prixMarcheConsommation!.prix_mesure != null ? widget.prixMarcheConsommation!.prix_mesure!.toString() : "0";
    documentController.text = widget.prixMarcheConsommation!.document != null ? widget.prixMarcheConsommation!.document!.toString() : " ";
    niveauApprovisionnementController.text = widget.prixMarcheConsommation!.niveau_approvisionement != null ? widget.prixMarcheConsommation!.niveau_approvisionement!.toString() : " ";
    produitController.text = widget.prixMarcheConsommation!.produit != null ? widget.prixMarcheConsommation!.produit!.toString() : " ";

    }
    _searchController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Ajouter Prix Marché Consommation', style: TextStyle(color: blanc, fontSize: 20, fontWeight: FontWeight.bold),),
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
                            keyboardType: TextInputType.text,
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
                              "Unité de mesure du prix *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: uniteMesurePrixController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez l'unité de messure du prix",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez l'unité de mesure du prix";
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
                              "Document *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: documentController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Choisir le document",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez choisir le document";
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
                       
                            
     const SizedBox(height: 20,),
     Center(
        child: SizedBox(
          width:double.infinity,
          child: ElevatedButton(
                            onPressed: () async {
                           
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