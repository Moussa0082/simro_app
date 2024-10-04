
 import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

   LoadingOverlay({
    required this.isLoading,
    required this.child,
     this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? Container(
                color: Colors.black.withOpacity(0.5), // Opacité pour l'arrière-plan
                child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: (Color.fromARGB(255, 180, 224, 182)),
          color: (vert),
                  ), 
                  // Indicateur de chargement
                ),
              )
            : SizedBox(), // Utilisé pour cacher l'indicateur de chargement
      ],
    );
  }
}


