import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/screens/profil.dart';



class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String firstName;
  final String lastName;

  ResponsiveAppBar({required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: vert, // Couleur de fond de l'AppBar
      automaticallyImplyLeading: false, // Désactive le bouton de retour par défaut
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icône de profil à gauche
          GestureDetector(
            onTap: (){
                    Get.to(ProfilScreen(), transition: Transition.upToDown, duration: Duration(seconds: 1));
                  },
            child: Row(
              children: [
                ProfilePhoto(
                              totalWidth: 50,
                              cornerRadius: 50,
                              color: Colors.black,
                              image: const AssetImage('assets/images/profil.jpg'),
                            ), // Icône de profil
                SizedBox(width: 10), // Espacement entre l'icône et le texte
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      lastName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Icône de notification à droite
          IconButton(
            icon: Icon(Icons.circle_notifications, size: 40, color: Colors.white),
            onPressed: () {
              // Action lorsque l'icône de notification est pressée
              print("Notification pressed");
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Taille de l'AppBar
}