import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/functions/functions.dart';
import 'package:simro/screens/detail_enquete.dart';
import 'package:simro/widgets/shimmer_effect.dart';

import 'detail_marche.dart';

class EnqueteCollecteScreen extends StatefulWidget {
  const EnqueteCollecteScreen({super.key});

  @override
  State<EnqueteCollecteScreen> createState() => _EnqueteCollecteScreenState();
}

class _EnqueteCollecteScreenState extends State<EnqueteCollecteScreen> {
  
   TextEditingController numFicheController = TextEditingController();
    TextEditingController marcheController = TextEditingController();
    TextEditingController collecteurController = TextEditingController();
    TextEditingController dateEnqueteController = TextEditingController();
    bool isLoading =true;

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
    // Si une date a été sélectionnée, l'afficher dans le TextFormField
    dateController.text = "${picked.day}/${picked.month}/${picked.year}";
  }
}


   
 
@override
  Widget build(BuildContext context) {

  // Simuler un délai de 4 secondes avant de charger les données
  Timer(const Duration(seconds: 4), () {
    isLoading = false;
    if (context.mounted) setState(() {});
  });


    return Scaffold(
      appBar: AppBar(
        title: Text("Enquête de collecte", style: TextStyle(color:blanc),),
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
                              _openDialog();
                              }
                                 if (result == 'synchroniser') {
                               showSyncDialog(context);
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'ajouter',
                                child: Text('Ajouter'),
                              ),
                              PopupMenuItem<String>(
                                value: 'synchroniser',
                                child: Text('Synchroniser'),
                              ),
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
              'Liste des enquête de collecte',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

              Expanded(
              child: isLoading ? buildShimmerListCorE() :  ListView.builder(
                itemCount: 3, // Par exemple, 3 fiches pour l'instant
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'N° fiche: 01',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                          ),
                          SizedBox(height: 5),
                          Text('Marché enquête: Bamako' ,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                          SizedBox(height: 5),
                          Text('Date Enquête: le 17/07/2024' ,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                          // SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                          Text('Date Enquête: le 17/07/2024' ,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, )),
                          // Bouton avec trois points
                          PopupMenuButton<String>(
                            iconColor:vert,
                            onSelected: (String result) {
                              if (result == 'modifier') {
                                // Action pour modifier
                                print('Modifier sélectionné');
                              } else if (result == 'detail') {
                                // Action pour détail
                                Get.to(DetailEnqueteScreen());
                                print('Détail sélectionné');
                              } else if (result == 'supprimer') {
                                // Action pour supprimer
                                print('Supprimer sélectionné');
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'modifier',
                                child: Text('Modifier'),
                              ),
                              PopupMenuItem<String>(
                                value: 'detail',
                                child: Text('Détail'),
                              ),
                              PopupMenuItem<String>(
                                value: 'supprimer',
                                child: Text('Supprimer'),
                              ),
                            ],
                          ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
              
            
          ],
        ),
      ),
     
    );
  }

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


    Future<void> _openDialog() async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Form(
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
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Ajout d'enquête de collecte",
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
                    keyboardType: TextInputType.text,
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
                  const SizedBox(height: 10),
          
                  // Collecteur
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Collecteur *",
                      style: TextStyle(color: (Colors.black), fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: _showMarche,
                    child: TextFormField(
                      onTap: _showMarche,
                      controller: collecteurController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down,
                            color: Colors.blueGrey[400]),
                        hintText: "Sélectionner un collecteur",
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
                          hintText: "Sélectionner une date",
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
                          onPressed: () async {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: vert, // Orange color code
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(310, 45),
                          ),
                          child: Text(
                            "Enregistrer",
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


}