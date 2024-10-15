// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:simro/constant/constantes.dart';
import 'package:simro/controller/network_controller.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/models/Collecteur.dart';
import 'package:simro/models/Enquete_Collecte.dart';
import 'package:simro/models/Marche.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/add_prix_marche_collecte.dart';
import 'package:simro/screens/detail_enquete_grossiste.dart';
import 'package:simro/screens/detail_enquete_collecte.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/services/Enquete_Service.dart';
import 'package:simro/services/Local_DataBase_Service.dart';
import 'package:simro/services/Marche_Service.dart';
import 'package:simro/widgets/Snackbar.dart';
import 'package:simro/widgets/loading_over_lay.dart';
import 'package:simro/widgets/shimmer_effect.dart';

import 'detail_marche.dart';

class EnqueteCollecteScreen extends StatefulWidget {
  const EnqueteCollecteScreen({super.key});

  @override
  State<EnqueteCollecteScreen> createState() => _EnqueteCollecteScreenState();
}

class _EnqueteCollecteScreenState extends State<EnqueteCollecteScreen> {
  
      final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    TextEditingController numFicheController = TextEditingController();
    late TextEditingController _searchController;
    List<EnqueteCollecte> enqueteCollecteList = [];


    TextEditingController marcheController = TextEditingController();
    TextEditingController collecteurController = TextEditingController();
    TextEditingController dateEnqueteController = TextEditingController();
    bool isLoading =true;
    bool isLoading1 =false;
    late Marche marche;
    late Future<List<Marche>> _marcheList;
    bool isOffline = false;

     bool isConnected = false;

    // Controller pour gérer la date sélectionnée
    TextEditingController dateController = TextEditingController();

     void checkConnectivity() async {
 final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
// if (connectivityResult.contains(ConnectivityResult.mobile)) {
//   print("mobile");
//   // Mobile network available.
// } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
//   // Wi-fi is available.
//    print("wifi");
//   // Note for Android:
//   // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
// } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
//    print("ethernet");
//   // Ethernet connection available.
// } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
//    print("vpn");
//   // Vpn connection active.
//   // Note for iOS and macOS:
//   // There is no separate network interface type for [vpn].
//   // It returns [other] on any device (also simulator)
// } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
//    print("blutooth");
//   // Bluetooth connection available.
// } else if (connectivityResult.contains(ConnectivityResult.other)) {
//    print("autres ");
//   // Connected to a network which is not in the above mentioned networks.
// } else 
if (connectivityResult.contains(ConnectivityResult.none)) {
   print("hors connexion ");
  // No available network types
}else{
   print(" connexion établie");

}
}
// Vérification de la connectivité
 





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

      Future<List<EnqueteCollecte>> fetchEnqueteCollecte() async {
  try {
    // Appel du service pour récupérer les données d'enquêtes
     
    List<EnqueteCollecte> fetchedList = await LocalDatabaseService().getAllEnquetes().then((enquetes) {
  //    LocalDatabaseService().getAllEnquetes().then((enquete) {
    setState(() {
      enqueteCollecteList = enquetes;
      // isLoading = false;
    });
  // });
    // setState(() {
    //   enqueteCollecteList.addAll(enquetes);
    // });
    return enqueteCollecteList;
  });
    
      enqueteCollecteList = fetchedList;
        // Retourner la liste mise à jour
    return enqueteCollecteList;
  } catch (e) {
    print("Erreur lors de la récupération des enquetes collecte : $e");
    return [];
  }
  
}
 
       LocalDatabaseService dbHelper = LocalDatabaseService();

   Future<void> fetchAndSyncMarche() async {
  final st = Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;
  final enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);

  if (st == true) {
    try {
      final response = await http.get(Uri.parse("$apiUrl/marche-by-collecteur-code/${enqueteurProvider.enqueteur!.code}/"));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        List<Marche> marches = responseData.map((e) => Marche.fromMap(e)).toList();

        // Récupérer la liste des marchés déjà présents en local
       await dbHelper.deleteAllMarches();

        // Filtrer les marchés pour éviter les doublons (basé sur le nom du marché)
        for (var marche in marches) {
          // Si le marché n'existe pas déjà en local (par nom), on l'insère
            await dbHelper.addMarche(marche);
          
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération des marches : $e");
    }
  }

  // Récupérer et mettre à jour la liste locale après synchronisation
  _marcheList =  dbHelper.getAllMarche();
}




 
 @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _marcheList = dbHelper.getAllMarche();

    // _marcheList =
    //     http.get(Uri.parse('$apiUrl/marche-by-collecteur-code/${enqueteurProvider.enqueteur!.code}/'));

       fetchAndSyncMarche();   
 // Charger les enquêtes locales
  LocalDatabaseService().getAllEnquetes().then((enquetes) {
    setState(() {
      enqueteCollecteList = enquetes;  // Assigner les produits récupérés à la liste locale
      isLoading = false;  // Désactiver le chargement
    });

   
  });
}

   Future<void> _openDialog(bool isEditMode,{EnqueteCollecte? enqueteCollecte}) async {
  if(isEditMode){
  numFicheController.text = enqueteCollecte!.num_fiche!;
  marcheController.text = enqueteCollecte.marche!;
  dateController.text = enqueteCollecte.date_enquete!;
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
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                       !isEditMode ? "Ajout d'enquête de collecte" : "Modifier d'enquête de collecte",
                          maxLines:1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        style: const TextStyle(
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
                      "Numéro de fiche*",
                      style: TextStyle(color: (Colors.black), fontSize: 18),
                    ),
                  ),
                  TextFormField(
                    controller: numFicheController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      hintText: "Entrez le numéro de fiche",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Veuillez entrer le numéro de fiche";
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
                          
if (!isEditMode && formkey.currentState!.validate()) {
  showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement

  final st = Get.put<NetworkController>(NetworkController(), permanent: true).isConnectedToInternet;

  // Si l'utilisateur est hors ligne
  if (st == false) {
    print("hors ligne");
    Snack.error(titre: "Alerte", message: "Vous êtes hors connexion");

    EnqueteCollecte enquete = EnqueteCollecte(
      collecteur: enqueteurProvider.enqueteur!.id_personnel!,
      num_fiche: numFicheController.text,
      marche: marcheController.text,
      date_enquete: dateController.text,
      isSynced: 0,
    );

    // Insérer l'enquête localement et récupérer l'ID généré
    await LocalDatabaseService().insertEnqueteCollecteAndsendId(enquete).then((generatedId) {
      // Mettre à jour l'objet enquete avec l'ID généré
      enquete.id_enquete = generatedId;

      LocalDatabaseService().getAllEnquetes().then((enquetes) {
        setState(() {
          enqueteCollecteList = enquetes;
          isLoading = false;
        });
        numFicheController.clear();
        dateController.clear();
        marcheController.clear();
        hideLoadingDialog(context);

        // Redirection après mise à jour de l'UI avec l'ID correct
        Get.to(AddPrixMarcheCollecteScreen(isEditMode: false, id_enquete: enquete.id_enquete!));
      });
    }).catchError((error) {
      // Gérer l'erreur
      print("Erreur lors de l'insertion locale : $error");
      Snack.error(titre: "Erreur", message: "Impossible de sauvegarder l'enquête");
      hideLoadingDialog(context);
    });
  }
}

//   else{
//       print("en ligne");
//            showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement

//                                             //   print("valid");
//                           try {
//   // Convertir la date de String à DateTime
//   DateTime dateEnquete = DateTime.parse(dateController.text);

//   // Ajouter l'enquête collectée
//   await EnqueteService().addEnqueteCollecte(
//     id_personnel: enqueteurProvider.enqueteur!.id_personnel!,
//     num_fiche: numFicheController.text,
//     marche: marche.id_marche!.toString(),
//     collecteur: enqueteurProvider.enqueteur!.id_enqueteur.toString(),
//     date_enquete: dateEnquete,
//   ).then((value) {
//     hideLoadingDialog(context);
//   });

//   // Appliquer les changements via le Provider
//   Provider.of<EnqueteService>(context, listen: false).applyChange();

//   // Récupérer la nouvelle liste d'enquêtes collectées
//   List<EnqueteCollecte> nouvelleListe = await fetchEnqueteCollecte();

//   // Mettre à jour l'état avec la nouvelle liste
//   setState(() {
//     isLoading = false;
//     enqueteCollecteList = nouvelleListe;
//   });
//   numFicheController.clear();
//   dateController.clear();
//   marcheController.clear();

//   // Fermer le dialogue
//   Navigator.of(context).pop();

// } catch (e) {
//   final String errorMessage = e.toString();
//   print("Erreur : " + errorMessage);

//   // Gérer l'erreur ici
// }
// }

                          
//                           else if(formkey.currentState!.validate() && isEditMode ) {
//                               showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
   
//                              try {
//   // Convertir la date de String à DateTime
//   DateTime dateEnquete = DateTime.parse(dateController.text);


//   await EnqueteService()
//       .updateEnqueteCollecte(
//         id_enquete: enqueteCollecte!.id_enquete!,
//         num_fiche: numFicheController.text,
//         marche: marcheController.text,
//         date_enquete: dateEnquete,
//       collecteur: enqueteurProvider.enqueteur!.id_enqueteur.toString(),
//       ).then((value) {
//         hideLoadingDialog(context);
//       });
//             Provider.of<EnqueteService>(context, listen: false).applyChange();
//            List<EnqueteCollecte> nouvelleListe = await fetchEnqueteCollecte();

//   // Mettre à jour l'état avec la nouvelle liste
//   setState(() {
//     isLoading = false;
//     enqueteCollecteList = nouvelleListe;
//   });
//    numFicheController.clear();
//   dateController.clear();
//   marcheController.clear();
//             Navigator.of(context).pop();
          
// } catch (e) {
//   final String errorMessage = e.toString();
//   print("erreur m: " + errorMessage);
// }

//                                 }
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
                            style:const TextStyle(
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
   
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:const Text("Enquête de collecte", style: TextStyle(color:blanc),),
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
                              _openDialog(false);
                              }
                              //    if (result == 'synchroniser') {
                              //  showSyncDialog(context);
                              // }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                             const PopupMenuItem<String>(
                                value: 'ajouter',
                                child: Text('Ajouter'),
                              ),
                            //  const PopupMenuItem<String>(
                            //     value: 'synchroniser',
                            //     child: Text('Synchroniser'),
                            //   ),
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
                  controller:_searchController,
                decoration: InputDecoration(
                   contentPadding: const EdgeInsets.all(10),
                  hintText: "recherche .............",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
           const SizedBox(height: 10),
            // Liste des prix de marché de consommation
           const Text(
              'Liste des enquête de collecte',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
    
              Expanded(
              child: isLoading ? buildShimmerListCorE() : 
                
                  Builder(
                builder: (context) {
                  String searchText = _searchController.text.toLowerCase();

                  // Filtrer la liste des enquetes en fonction du texte recherché
                  List<EnqueteCollecte> filteredList = enqueteCollecteList
                      .where((enquete) => enquete.num_fiche!.toLowerCase().contains(searchText))
                      .toList();

                  // Afficher un message si aucun résultat n'est trouvé
                 // Afficher un message si aucun résultat n'est trouvé
              if (filteredList.isEmpty && !isLoading && !isLoading1) {
                return const Center(
                  child: Text('Aucun résultat trouvé'),
                );
              }
                  
                  return ListView.builder(
                    itemCount: filteredList.length, // Par exemple, 3 fiches pour l'instant
                    itemBuilder: (context, index) {
                      
                      final enquete = filteredList[index];
                      return GestureDetector(
                        onTap:(){
                          if(enquete.isSynced != 1){
                            print("non sync");
                          }else{
                            print("sync");
                            
                          }
                        },
                        child: Card(
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
                                  'N° fiche: ${enquete.num_fiche!}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                                ),
                             const   SizedBox(height: 5),
                                Text('Marché enquête: ${enquete.marche!}' ,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                                // SizedBox(height: 5),
                               
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                        
                                Text('Date Enquête: le ${enquete.date_enquete}' ,
                                  style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                                // Bouton avec trois points
                                PopupMenuButton<String>(
                                  iconColor:vert,
                                  onSelected: (String result) async{
                                    if (result == 'modifier') {
                                      // Action pour modifier
                                       _openDialog(true,enqueteCollecte:enquete);
                                      print('Modifier sélectionné');
                                    } 
                                    else if (result == 'detail') {
                                      // Action pour détail
                                      Get.to(DetailEnqueteCollecteScreen(enqueteCollecte: enquete,), transition: Transition.rightToLeftWithFade, duration: const Duration(seconds: 1));
                                      print('Détail sélectionné');
                                    } 

                                    else if (result == 'synchroniser' && enquete.isSynced != null &&  enquete.isSynced != 1)  {
                                      
     showLoadingDialog(context, "Veuillez patienter"); // Affiche le dialogue de chargement
                                       try {
       final  enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);

  // Convertir la date de String à DateTime
   DateTime parsedDate = DateTime.parse(enquete.date_enquete!);
  // Ajouter l'enquête collectée
  await EnqueteService().addEnqueteCollecte(
    id_code_mobile: enquete.id_enquete!,
    id_personnel: enqueteurProvider.enqueteur!.id_personnel!,
    num_fiche: enquete.num_fiche!,
    marche: enquete.marche!,
    collecteur: enqueteurProvider.enqueteur!.id_enqueteur.toString(),
    date_enquete:parsedDate,
  ).then((value) {
    if(value != null){
    LocalDatabaseService().deleteEnqueteCollecte(enquete.id_enquete!).then((value) {
          hideLoadingDialog(context); // Cache le dialogue de chargement
    });
      setState(() {
                  enqueteCollecteList.removeWhere((item) => item.id_enquete == enquete.id_enquete);
      });
   }else{
      Snack.error(titre: "Erreur", message: "Une erreur s'est produite veuillez réessayer");
            hideLoadingDialog(context);
    }
  });

  // Appliquer les changements via le Provider
  Provider.of<EnqueteService>(context, listen: false).applyChange();

  // Récupérer la nouvelle liste d'enquêtes collectées
  List<EnqueteCollecte> nouvelleListe = await fetchEnqueteCollecte();

  // Mettre à jour l'état avec la nouvelle liste
  setState(() {
    isLoading = false;
    enqueteCollecteList.addAll(nouvelleListe);
  });
  numFicheController.clear();
  dateController.clear();
  marcheController.clear();

  // Fermer le dialogue
  // Navigator.of(context).pop();

} catch (e) {
  final String errorMessage = e.toString();
  print("Erreur : " + errorMessage);
      hideLoadingDialog(context);

  // Gérer l'erreur ici
}
                                      print('Synchroniser sélectionné');
                                    } 
                                    else if (result == 'supprimer') {
                                      // Action pour supprimer
                                      EnqueteService().deleteEnqueteCollecte(enquete.id_enquete!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            enqueteCollecteList.removeWhere((item) => item.id_enquete == enquete.id_enquete);
                          });
                        });
                                      print('Supprimer sélectionné');
                                    }
                                    else if (result == 'lier') {
                                    Get.to(AddPrixMarcheCollecteScreen(isEditMode: false, id_enquete: enquete.id_enquete,));
                                      print('Supprimer sélectionné');
                                    }
                                    else if (result == 'supprimee') {
                                      final dbService = LocalDatabaseService();  // Créer une instance
final db = await dbService.database;  
  final result = await db.rawQuery('''
    SELECT * FROM prix_marche_collecte WHERE enquete = ?
  ''', [enquete.id_enquete]);

  if (result.isNotEmpty) {
    // Si des objets liés à l'enquête sont trouvés dans la table prix_marche_grossiste
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enquête non synchronisée'),
          content: Text('Vous devez synchroniser l\'enquête avant de la supprimer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    // Si l'enquête n'est pas liée, permettre la suppression
                                      // Action pour supprimer
                                      LocalDatabaseService().deleteEnqueteCollecte(enquete.id_enquete!).then((value) {
                          // Update the original list used by ListView.builder
                          setState(() {
                            enqueteCollecteList.removeWhere((item) => item.id_enquete == enquete.id_enquete);
                          });
                        });
                                      print('Supprimer sélectionné');
                                    }}
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
                                      value: 'lier',
                                      child: Text('Ajouter une colllecte'),
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
                                  ,
                                ),
                                  ],
                                ),
                              ],
                            ),
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
                    hintText: 'Rechercher un marche',
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
                    return  buildShimmerSelectList();
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Erreur lors du chargement des données"),
                    );
                  }

                  if (snapshot.hasData) {
                   
                   List<Marche> typeListe = snapshot.data as List<Marche>;

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




 // Afficher la boîte de dialogue avec la liste des marchés locaux
    void _showMarcheDialog(List<Marche> localMarcheList) {
  showDialog(
    context: this.context,
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
            content: localMarcheList.isEmpty
                ? const Center(child: Text("Aucun marché disponible en local"))
                : SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: localMarcheList.length,
                      itemBuilder: (context, index) {
                        final type = localMarcheList[index];
                        final isSelected = marcheController.text == type.nom_marche!;
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                type.nom_marche!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(
                                      Icons.check_box_outlined,
                                      color: vert,
                                    )
                                  : null,
                              // onTap: () {
                              //   setState(() {
                              //     marche = type;
                              //     marcheController.text = type.nom_marche!;
                              //   });
                              // },
                              onTap: () {
  setState(() {
    marche = type;  // Définit le marché sélectionné
    marcheController.text = type.nom_marche!;
  });
},

                            ),
                            Divider()
                          ],
                        );
                      },
                    ),
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

// Méthode pour sauvegarder les marchés localement et gérer la suppression
Future<void> _saveMarketsLocally(List<Marche> marcheList) async {
  // Récupérer la liste actuelle des marchés dans la base locale
  List<Marche> localMarcheList = await LocalDatabaseService().getAllMarche();

  // Identifier les nouveaux marchés à ajouter
  List<Marche> newMarcheList = marcheList
      .where((marche) => !localMarcheList.any((local) => local.id_marche == marche.id_marche))
      .toList();

  // Ajouter les nouveaux marchés
  for (Marche marche in newMarcheList) {
    await LocalDatabaseService().addMarche(marche);
  }

  // Identifier les marchés à supprimer
  List<Marche> deletedMarcheList = localMarcheList
      .where((local) => !marcheList.any((marche) => marche.id_marche == local.id_marche))
      .toList();

  // Supprimer les marchés obsolètes
  for (Marche marche in deletedMarcheList) {
    await LocalDatabaseService().deleteMarche(marche.id_marche!);
  }
}


  //collecteur  de données

  


}