import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/controller/network_controller.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Collecteur.dart';
import 'package:simro/models/Enquete.dart';
import 'package:simro/models/Marche.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/detail_enquete_grossiste.dart';
import 'package:simro/screens/detail_marche.dart';
import 'package:simro/services/Enquete_Service.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/widgets/Snackbar.dart';
import 'package:simro/widgets/loading_over_lay.dart';
import 'package:simro/widgets/shimmer_effect.dart';

class EnqueteScreen extends StatefulWidget {
  const EnqueteScreen({super.key});

  @override
  State<EnqueteScreen> createState() => _EnqueteScreenState();
}

class _EnqueteScreenState extends State<EnqueteScreen> {


      final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    TextEditingController observationController = TextEditingController();
    TextEditingController statutController = TextEditingController();
    TextEditingController marcheController = TextEditingController();
    TextEditingController collecteurController = TextEditingController();
    TextEditingController dateEnqueteController = TextEditingController();
    bool isLoading =true;
        late TextEditingController _searchController;
    List<Enquete> enqueteList = [];

       late Marche marche;
    late Future _marcheList;


    // Controller pour gérer la date sélectionnée
TextEditingController dateController = TextEditingController();

// Méthode pour afficher le DatePicker
 Future<void> _selectDate(BuildContext context) async {
  DateTime currentDate = DateTime.now();
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: currentDate, // Date initiale
    firstDate: currentDate,   // Date minimale (date du jour)
    lastDate: DateTime(2100), // Date maximale, vous pouvez la changer
    helpText: 'Sélectionner une date d\'enquête', // Texte d'aide
    cancelText: 'Annuler',
    confirmText: 'OK',
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light(), // Ajustez le thème si nécessaire
        child: child!,
      );
    },
  );

  if (picked != null && picked != currentDate) {
    // Si une date a été sélectionnée, formater le mois et le jour avec deux chiffres
    String formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

    // Afficher la date formatée dans le TextFormField
    dateController.text = formattedDate;
  }
}


 Future<List<Enquete>> fetchEnquete() async {
  try {
    // Appel du service pour récupérer les données d'enquêtes
    List<Enquete> fetchedList = await EnqueteService().fetchEnquete();
    
    // Mettre à jour la liste locale avec les nouvelles données
    enqueteList = fetchedList;
    
    // Retourner la liste mise à jour
    return enqueteList;
  } catch (e) {
    print("Erreur lors de la récupération des enquêtes : $e");
    return [];
  }
}

   @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
     final  enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);
    _marcheList =
        http.get(Uri.parse('$apiUrl/marche-by-collecteur-code/${enqueteurProvider.enqueteur!.code}/'));

             // Appel pour récupérer les produits au chargement de la page
             LocalDatabaseService().getAllEnquetesConsommation().then((value) {
              enqueteList = value;
     EnqueteService().fetchEnquete().then((enquetes) {
    setState(() {
      enqueteList.addAll(enquetes);  // Assigner les produits récupérés à la liste locale
      isLoading = false;  // Désactiver le chargement
    });
  });
             });
  }
  
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Enquête ", style: TextStyle(color:blanc),),
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
                              _openDialog(false);
                              }
                              //  if (result == 'synchroniser') {
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
             // Zone de recherche
                  Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                onChanged: (value) {
                setState(() {
                  // Mettre à jour l'état à chaque saisie
                });
              },
                  controller:_searchController,
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
              'Liste des enquêtes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
    
              Expanded(
              child: isLoading ? buildShimmerListCorE() : 
                
                  Builder(
                builder: (context) {
                  String searchText = _searchController.text.toLowerCase();

                  // Filtrer la liste des enquetes en fonction du texte recherché
                  List<Enquete> filteredList = enqueteList
                      .where((enquete) => enquete.date_enquete!.toLowerCase().contains(searchText))
                      .toList();

                  // Afficher un message si aucun résultat n'est trouvé
                  if (filteredList.isEmpty) {
                    return const Center(
                      child: Text('Aucun résultat trouvé'),
                    );
                  }
                  return ListView.builder(
                    itemCount: filteredList.length, // Par exemple, 3 fiches pour l'instant
                    itemBuilder: (context, index) {
                      
                      final enquete = filteredList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Align(
                                  alignment: Alignment.topRight,
                                  child: enquete.isSynced != null &&  enquete.isSynced != 1  ? Icon(
                                 Icons.cloud_off,
                                color: enquete.isSynced != 1 ? Colors.red :Colors.green ,
                              ) : SizedBox(),
                                ),
                              Text(
                                'Observation: ${enquete.observation!}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                              ),
                              SizedBox(height: 5),
                              Text('Marché enquête: ${enquete.marche!}' ,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              SizedBox(height: 5),
                              Text('Statut: ${enquete.statut!}' ,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              // SizedBox(height: 5),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                      
                              Text('Date Enquête: le ${enquete.date_enquete}' ,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                              // Bouton avec trois points
                              PopupMenuButton<String>(
                                iconColor:vert,
                                onSelected: (String result) async{
                                  if (result == 'modifier') {
                                    // Action pour modifier
                                     _openDialog(true,enquete:enquete);
                                    print('Modifier sélectionné');
                                  } else if (result == 'detail') {
                                    // Action pour détail
                                    // Get.to(DetailEnqueteCollecteScreen(enqueteCollecte: enquete,), transition: Transition.rightToLeftWithFade, duration: const Duration(seconds: 1));
                                    print('Détail sélectionné');
                                  } else if (result == 'supprimer') {
                                    // Action pour supprimer
                                    EnqueteService().deleteEnquete(enquete.id_enquete!).then((value) {
                        // Update the original list used by ListView.builder
                        setState(() {
                          enqueteList.removeWhere((item) => item.id_enquete == enquete.id_enquete);
                        });
                      });
                                    print('Supprimer sélectionné');
                                  }
                                            else if (result == 'synchroniser' && enquete.isSynced != null &&  enquete.isSynced != 1)  {
                                         showLoadingDialog(context, "Veuillez patienter"); 
                                       try {
       final  enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);

  // Convertir la date de String à DateTime
   DateTime parsedDate = DateTime.parse(enquete.date_enquete!);
  // Ajouter l'enquête collectée
  await EnqueteService().addEnquete(
    statut: enquete.statut!,
    observation: enquete.observation!,
    marche: enquete.marche!,
    collecteur: enqueteurProvider.enqueteur!.id_enqueteur!,
    date_enquete:parsedDate,
  ).then((value) => {
    LocalDatabaseService().deleteEnqueteConsommation(enquete.id_enquete!).then((value) {
      hideLoadingDialog(context);
    })
  });

  // Appliquer les changements via le Provider
  Provider.of<EnqueteService>(context, listen: false).applyChange();
  // Récupérer la nouvelle liste d'enquêtes collectées
  List<Enquete> nouvelleListe = await fetchEnquete();

  // Mettre à jour l'état avec la nouvelle liste
  setState(() {
    isLoading = false;
    enqueteList = nouvelleListe;
  });
  dateController.clear();
  marcheController.clear();

  // Fermer le dialogue
  Navigator.of(context).pop();

} catch (e) {
  final String errorMessage = e.toString();
  print("Erreur : " + errorMessage);

  // Gérer l'erreur ici
}
                                      print('Synchroniser sélectionné');
                                    } 
                                                  else if (result == 'supprimee') {
                                      // Action pour supprimer
                                      LocalDatabaseService().deleteEnqueteConsommation(enquete.id_enquete!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            enqueteList.removeWhere((item) => item.id_enquete == enquete.id_enquete);
                          });
                        });
                        }
                                },
                                itemBuilder: (BuildContext context) => enquete.isSynced != null &&  enquete.isSynced != 1 ?   
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
                                  ]
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

   

     Future<void> _openDialog(bool isEditMode,{Enquete? enquete}) async {
  if(isEditMode){
  observationController.text = enquete!.observation!;
  statutController.text = enquete.statut!;
  marcheController.text = enquete.marche!;
  dateController.text = enquete.date_enquete!;
  }
 final  enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close button at the top-right corner
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  
                  // Title of the form
                   Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                       !isEditMode ? "Ajout d'enquête" : "Modifier d'enquête",
                          maxLines:1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  
                  // Numéro de fiche
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Observation*",
                      style: TextStyle(color: (Colors.black), fontSize: 18),
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
                        return "Veuillez entrer l'observation";
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Statut*",
                      style: TextStyle(color: (Colors.black), fontSize: 18),
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
                        return "Veuillez entrer le statut";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
          
                  // Marché
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Marché*",
                      style: TextStyle(color: (Colors.black), fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: showMarche,
                    child: TextFormField(
                      onTap: showMarche,
                      controller: marcheController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down,
                            color: Colors.blueGrey[400]),
                        hintText: "Sélectionner un marché" ,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
          
                  // Date d'enquête
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Date d'enquête *",
                      style: TextStyle(color: (Colors.black), fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today,
                              color: Colors.blueGrey[400]),
                          hintText:  "Sélectionner une date",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                        Center(
        child: ElevatedButton(
                          onPressed: () async  {
                           final st =  Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;

 
                          if (formkey.currentState!.validate() && !isEditMode) {
     showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
          if (st == false) {
   print("hors ligne");
  // Mobile network available.
    Snack.error(titre: "Alerte", message:"Vous êtes hors connexion");
    Enquete enquete = Enquete(
      collecteur:enqueteurProvider.enqueteur!.id_enqueteur!,
    observation: observationController.text,
    marche: marcheController.text,
    statut: statutController.text,
    date_enquete: dateController.text,
    isSynced: 0,
  );
    await LocalDatabaseService().insertEnqueteConsommation(enquete).then((value) => {
        LocalDatabaseService().getAllEnquetesConsommation().then((enquetes) {
    setState(() {
      enqueteList = enquetes;
      isLoading = false;
    });
    hideLoadingDialog(context);
  })
    });
  }else{
      print("en ligne");
      showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement

                          try {
  // Convertir la date de String à DateTime
  DateTime dateEnquete = DateTime.parse(dateController.text);

  // Ajouter l'enquête collectée
  await EnqueteService().addEnquete(
    statut: statutController.text,
    observation: observationController.text,
    marche: marche.id_marche!.toString(),
    collecteur: enqueteurProvider.enqueteur!.id_enqueteur!,
    date_enquete: dateEnquete,
  ).then((value){
    hideLoadingDialog(context);
  });

  // Appliquer les changements via le Provider
  Provider.of<EnqueteService>(context, listen: false).applyChange();

  // Récupérer la nouvelle liste d'enquêtes collectées
  List<Enquete> nouvelleListe = await fetchEnquete();

  // Mettre à jour l'état avec la nouvelle liste
  setState(() {
    isLoading = false;
    enqueteList = nouvelleListe;
  });
  observationController.clear();
  statutController.clear();
  dateController.clear();
  marcheController.clear();

  // Fermer le dialogue
  Navigator.of(context).pop();

} catch (e) {
  final String errorMessage = e.toString();
  print("Erreur : " + errorMessage);

  // Gérer l'erreur ici
}
                          }

                          }else if(formkey.currentState!.validate() && isEditMode) {
                                 showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement

                            try {
  // Vérifiez que enqueteurProvider.enqueteur et enquete ne sont pas nulls
  if (enqueteurProvider.enqueteur != null && enquete != null) {
    // Convertir la date de String à DateTime
    DateTime dateEnquete = DateTime.parse(dateController.text);

    print("id collecteur: " + enqueteurProvider.enqueteur!.id_enqueteur!.toString());

    await EnqueteService().updateEnquete(
      collecteur: enqueteurProvider.enqueteur!.id_enqueteur!,
      id_enquete: enquete.id_enquete!,
      statut: statutController.text,
      observation: observationController.text,
      marche: marcheController.text,
      date_enquete: dateEnquete,
    ).then((value) {
      hideLoadingDialog(context);
    });

    // Rafraîchir la liste
    Provider.of<EnqueteService>(context, listen: false).applyChange();
    List<Enquete> nouvelleListe = await fetchEnquete();

    // Mettre à jour l'état avec la nouvelle liste
    setState(() {
      isLoading = false;
      enqueteList = nouvelleListe;
    });

    // Vider les contrôleurs
    observationController.clear();
    statutController.clear();
    dateController.clear();
    marcheController.clear();

    Navigator.of(context).pop();
  } else {
    print("Erreur : enqueteur ou enquete est null");
  }
} catch (e) {
  final String errorMessage = e.toString();
  print("Erreur m: " + errorMessage);
}


                                }
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: vert, // Orange color code
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(310, 45),
                          ),
                          child: Text(
                           !isEditMode ? "Enregistrer" : "Modifier",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
      )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

     // Fonction pour récupérer la liste des marchés depuis l'API

  void showMarche() async {
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
              content: FutureBuilder(
                future: _marcheList,
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
                    final responseData =
                        json.decode(utf8.decode(snapshot.data.bodyBytes));
                    if (responseData is List) {
                      List<Marche> typeListe = responseData
                          .map((e) => Marche.fromMap(e))
                          .toList();

                      if (typeListe.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child:
                              Center(child: Text("Aucun marché trouvée")),
                        );
                      }

                      String searchText = _searchController.text.toLowerCase();
                      List<Marche> filteredSearch = typeListe
                          .where((type) => type.nom_marche!
                              .toLowerCase()
                              .contains(searchText))
                          .toList();

                      return filteredSearch.isEmpty
                          ? const Text(
                              'Aucun marché trouvée',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            )
                          : SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                itemCount: filteredSearch.length,
                                itemBuilder: (context, index) {
                                  final type = filteredSearch[index];
                                  final isSelected = marcheController.text ==
                                      type.nom_marche!;

                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          type.nom_marche!,
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
                                            marche = type;
                                            marcheController.text =
                                                type.nom_marche!;
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
                    print('Options sélectionnées : $marche');
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


    
}