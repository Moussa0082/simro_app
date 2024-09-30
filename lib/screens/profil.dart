import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  
 @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
                  backgroundColor: const Color.fromARGB(246, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: vert,
          title: Text('Profile', style:TextStyle(color: blanc, fontWeight: FontWeight.bold)),
          centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios, color: blanc)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(color: blanc, Icons.edit),
            ),
          ],
         
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Avatar avec icône de caméra
              Stack(
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
              SizedBox(height: 20),
              
              // Listes d'options
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: vert),
                      title: Text('Moussa BANE'),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'My Account'
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person, color: vert),
                      title: Text(' Develeoppeur'),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'Notifications'
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.mail, color: vert),
                      title: Text('bane8251@gmail.com'),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'Settings'
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on, color: vert),
                      title: Text('Bamako'),
                      // trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'Help Center'
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Deconnexion'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action sur 'Log Out'
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