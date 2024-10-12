import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Prix_Marche_Grossiste.dart';
import 'package:simro/screens/prix_marche_grossiste.dart';
import 'package:simro/services/Prix_Marche_Service.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class AddPrixMarcheGrossisteScreen extends StatefulWidget {
   bool? isEditMode;
   PrixMarcheGrossiste? prixMarcheGrossiste;
   AddPrixMarcheGrossisteScreen({super.key, this.isEditMode, this.prixMarcheGrossiste});

  @override
  State<AddPrixMarcheGrossisteScreen> createState() => _AddPrixMarcheGrossisteScreenState();
}

class _AddPrixMarcheGrossisteScreenState extends State<AddPrixMarcheGrossisteScreen> {
 
 
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
  // TextEditingController statutController = TextEditingController();
  TextEditingController niveauApprovisionnementController = TextEditingController();
  // TextEditingController observationController = TextEditingController();
  TextEditingController produitController = TextEditingController();
  TextEditingController grossiteController = TextEditingController();
  bool isLoading = true;

   
 



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     if(widget.isEditMode == true){
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                              "Localité d'achat *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: localiteAchatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez la localité d'achat",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez la localité d'achat";
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez nombre d'unité de vente";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
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
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids moyen d'unité de vente";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
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
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le poids total d'unité de vente";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
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
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le prix unitaire de vente";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
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
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le client de la vente";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
                          ),
               const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Localité de la vente *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                   TextFormField(
                            controller: localiteVenteController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez la localité de la vente",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez la localité de la vente";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => nomActeur = val!,
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
                             onTap: null,
                             child: TextFormField(
                               onTap: null,
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
                              "Grossiste *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: null,
                             child: TextFormField(
                               onTap: null,
                               controller: grossiteController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner un grossiste",
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
                              if(widget.isEditMode == false){
                              
                              
                              }else{

                              }
                           
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