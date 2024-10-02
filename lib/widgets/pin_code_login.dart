import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:simro/models/Enqueteur.dart';
import 'package:simro/provider/Enqueteur_Provider.dart';
import 'package:simro/screens/home.dart';
import 'package:simro/services/EnqueteurService.dart';
import 'package:simro/widgets/pin_code.dart';

class PinCodeLoginScreen extends StatefulWidget {
  const PinCodeLoginScreen({super.key});

  @override
  State<PinCodeLoginScreen> createState() => _PinCodeLoginScreenState();
}

class _PinCodeLoginScreenState extends State<PinCodeLoginScreen> {

   


  bool isLoading = false;

  void storeUserSession(String token, Enqueteur enqueteur) async {
  final prefs = await SharedPreferences.getInstance();
  
  // Stocker le token
  await prefs.setString('access_token', token);
  
  // Convertir l'objet Enqueteur en JSON
  String enqueteurJson = json.encode(enqueteur.toJson());
  
  // Stocker l'objet Enqueteur sous forme de chaîne JSON
  await prefs.setString('enqueteur', enqueteurJson);
}
 
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Utiser un email',
                style: TextStyle(color: Colors.blueAccent),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Code Pin',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20),
            const Text('Utiliser votre code pin pour vous connecter'),
            const Text('Taille 5 chiffres'),
            const SizedBox(height: 60),
            Expanded(
              child: PinCodeWidget(
                minPinLength: 4,
                maxPinLength: 5,
                onChangedPin: (pin) {
                  // check the PIN length and check different PINs with 4,5.. length.
                  print("pin change" + pin);
                },
        onEnter: (pin, _) async {
  // Callback lorsque l'utilisateur appuie sur "Entrer"
  print("pin enter " + pin);

  // Définir isLoading à true
  setState(() {
    isLoading = true;
  });

  // Afficher le dialog de chargement
  final result = await showSimpleLoadingDialog<Map<String, dynamic>>(
    context: context,
    future: () async {
        // Appel au service de connexion
         EnqueteurProvider enqueteurProvider =
        Provider.of<EnqueteurProvider>(context, listen: false);

        final result = await EnqueteurService().loginWithPin(pin);

        // Vérifiez si le résultat contient les données nécessaires
        if (result.containsKey('access_token') && result.containsKey('enqueteur')) {
          final token = result['access_token'];
          final enqueteurInfo = result['enqueteur'];
        // Convertir le Map en un objet Enqueteur
        Enqueteur enqueteur = Enqueteur.fromMap(enqueteurInfo);

       // Mettre à jour le provider avec l'objet Enqueteur
         enqueteurProvider.setEnqueteur(enqueteur);
         storeUserSession(token, enqueteur);

          // Mettre à jour les informations nécessaires
          print('Connecté avec succès: $token');
          print('Informations de l\'enquêteur: $enqueteurInfo');

          // Retourner le résultat pour l'utiliser après la future
          return result;
        } else {
          // Gérer le cas où les données ne sont pas présentes
          print('Connexion échouée : données manquantes');
          return result;
        }
   
    },
  );

  // Après la future, faire les actions nécessaires avec 'result'
  if (result != null) {
    // Redirection vers la page HomeScreen
    Get.offAll(
      const HomeScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(seconds: 1),
    );
  }

  // Arrêter l'effet de chargement
  setState(() {
    isLoading = false;
  });
},

                centerBottomWidget: IconButton(
                  icon: const Icon(
                    Icons.fingerprint,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   void showMessageSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

}
