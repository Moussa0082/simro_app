import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/products.dart';
import 'package:simro/widgets/shimmer_effect.dart';
import 'package:path/path.dart' as path;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  
  
  late TextEditingController _searchController;

  TextEditingController codeProduitController = TextEditingController();
  TextEditingController nomProduitController = TextEditingController();
  TextEditingController filiereProduitController = TextEditingController();
  TextEditingController familleController = TextEditingController();
  TextEditingController categorieProduitController = TextEditingController();
  TextEditingController formeProduitController = TextEditingController();
  TextEditingController origineProduitcontroller = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String? imageSrc;
  
  bool isLoading = true;
   File? _imageFile; // Stocke l'image sélectionnée
   final ImagePicker _picker = ImagePicker();

    Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File('${directory.path}/$name');
    return image;
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = await getImage(source);
    if (image != null) {
      setState(() {
        _imageFile = image;
        imageSrc = image.path;
      });
    }
  }

  Future<File?> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return null;

    return File(image.path);
  }

    // Méthode pour sélectionner une image
   Future<void> _selectImageSource() async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Stack(
          children: [
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Sélectionner une image',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.camera_alt, size: 40),
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text('Caméra'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.photo_library, size: 40),
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text('Galerie'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      );
    },
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
        title: const  Text('Ajouter Produit', style: TextStyle(color: blanc, fontSize: 20, fontWeight: FontWeight.bold),),
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
                              "Code produit*",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: codeProduitController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le code du produit",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le code du produit";
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
                              "Nom produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: nomProduitController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez le nom du produit",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez le nom du produit";
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
                              "Filière produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  TextFormField(
                            controller: filiereProduitController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              hintText: "Entrez la filière du produit",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Veillez entrez la filière du produit";
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
                              "Famille produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: _showMarche,
                             child: TextFormField(
                               onTap: _showMarche,
                               controller: familleController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner la famille du produit ",
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
                              "Catgeorie produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: _showMarche,
                             child: TextFormField(
                               onTap: _showMarche,
                               controller: categorieProduitController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner la categorie du produit",
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10, horizontal: 20),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                               ),
                             ),
                           ),
                           const SizedBox(height: 15,),
                              const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Forme produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: _showMarche,
                             child: TextFormField(
                               onTap: _showMarche,
                               controller: formeProduitController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner la forme du produit",
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10, horizontal: 20),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                               ),
                             ),
                           ),
                           const SizedBox(height: 15,),
                              const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Origine produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                           GestureDetector(
                             onTap: _showMarche,
                             child: TextFormField(
                               onTap: _showMarche,
                               controller: categorieProduitController,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 suffixIcon: Icon(Icons.arrow_drop_down,
                                     color: Colors.blueGrey[400]),
                                 hintText: "Sélectionner l'origine du produit",
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10, horizontal: 20),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                               ),
                             ),
                           ),
                           const SizedBox(height: 15,),

            const Padding(
                            padding:  EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Image produit *",
                              style:
                                  TextStyle(color: (Colors.black), fontSize: 18),
                            ),
                          ),
                  // Champ texte pour choisir l'image
            GestureDetector(
              onTap: _selectImageSource,
              child: TextFormField(
                controller: imageController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintText: "Choisir l'image du produit",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectImageSource(); // Ouvre le sélecteur d'image
                    },
                    child: Icon(Icons.file_upload_outlined), // Icône d'image à gauche
                  ),
                ),
                keyboardType: TextInputType.text,
                enabled: false, // Empêche la saisie manuelle
              ),
            ),

           const SizedBox(height: 20), // Espacement

            // Conteneur pour prévisualiser l'image sélectionnée
            if (_imageFile != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            if (_imageFile == null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text("Aucune image sélectionnée"),
                ),
              ),

     const SizedBox(height: 20,),
     Center(
        child: SizedBox(
          width:double.infinity,
          child: ElevatedButton(
                            onPressed: () async {
                              Get.to(ProductsScreen() , transition: Transition.rightToLeft, duration: Duration(seconds: 2));
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