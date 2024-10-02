import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/public_home.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  // late EnqueteurProvider enqueteurProvider;

   void logoutUser() async {
  final prefs = await SharedPreferences.getInstance();
  
  // Supprimer le token et l'objet Enqueteur
  await prefs.remove('access_token');
  await prefs.remove('enqueteur');
  
  // Rediriger vers l'écran de connexion
  Get.offAll(const PublicHomeScreen(), transition: Transition.rightToLeft, duration:const Duration(seconds: 1));
}

  
 @override
  Widget build(BuildContext context) {
   final  enqueteurProvider = Provider.of<EnqueteurProvider>(context, listen: false);
    return 
       Scaffold(
                  backgroundColor: const Color.fromARGB(246, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: vert,
          title: const Text('Profile', style:TextStyle(color: blanc, fontWeight: FontWeight.bold)),
          centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios, color: blanc)),
          actions: const [
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Icon(color: blanc, Icons.edit),
            ),
          ],
         
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Avatar avec icône de caméra
             const Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo-simro.png'), // Remplacez par votre image
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            const  SizedBox(height: 20),
              
              // Listes d'options
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading:const Icon(Icons.person, color: vert),
                      title: Text('${enqueteurProvider.enqueteur!.prenom}'),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'My Account'
                      },
                    ),
                  const  Divider(),
                    ListTile(
                      leading:const Icon(Icons.person, color: vert),
                      title: Text('${enqueteurProvider.enqueteur!.nom} '),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'My Account'
                      },
                    ),
                  const  Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, color: vert),
                      title: Text(' ${enqueteurProvider.enqueteur!.contact}'),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'Notifications'
                      },
                    ),
                   const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: vert),
                      title: Text('${enqueteurProvider.enqueteur!.localite}'),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'Settings'
                      },
                    ),
                  //  const Divider(),
                  //   ListTile(
                  //     leading: const Icon(Icons.location_on, color: vert),
                  //     title: Text('${enqueteurProvider.enqueteur!.adresse}'),
                  //     // trailing: Icon(Icons.arrow_forward_ios),
                  //     onTap: () {
                  //       // Action sur 'Help Center'
                  //     },
                  //   ),
                   const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title:const Text('Deconnexion'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'Log Out'
                        logoutUser();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}