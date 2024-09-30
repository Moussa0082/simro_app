import 'dart:async';

import 'package:flutter/material.dart';


 double progressValue = 0.0;
 bool isSyncing = false;

   
 // Fonction pour afficher le pop-up de synchronisation
  void showSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Synchroniser les données'),
          content: Text('Voulez-vous synchroniser les données maintenant ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le pop-up
              },
              child: Text('Non'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le pop-up de confirmation
                _startSync(context); // Démarre la synchronisation et affiche le progress
              },
              child: Text('Oui'),
            ),
          ],
        );
      },
    );
  }

  bool isDialogOpen = false; // Variable pour suivre l'état d'ouverture du pop-up

  void _startSync(BuildContext context) {
  // setState(() {
    isSyncing = true;
    progressValue = 0.0;
  // });
  

    
    // Affiche le dialog avec la progression
    if (!isDialogOpen) {
    isDialogOpen = true;
  
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche de fermer le pop-up en cliquant en dehors
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            // Simuler la progression de la synchronisation de 0 à 100 % en 5 secondes
           Timer.periodic(Duration(milliseconds: 50), (Timer timer) {
  if (progressValue >= 1.0) {
    timer.cancel(); // Arrêter le timer quand la progression est terminée
     if (isDialogOpen) {
          Navigator.of(context).pop(); // Ferme le pop-up une fois que c'est terminé
          isDialogOpen = false; // Marquer le dialogue comme fermé
        }
  } else {
    setStateDialog(() {
      progressValue += 0.01; // Incrémenter la progression
    });
  }
});

            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: progressValue,
                          strokeWidth: 8,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Couleur verte
                          backgroundColor: Colors.grey[200], // Fond blanc/gris clair
                        ),
                      ),
                      Text(
                        '${(progressValue * 100).toInt()}%', // Pourcentage affiché
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Synchronisation en cours...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  }