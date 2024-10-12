
//  import 'package:flutter/material.dart';
// import 'package:simro/constant/constantes.dart';

// class LoadingOverlay extends StatelessWidget {
//   final bool isLoading;
//   final Widget child;
//   final String? message;

//    LoadingOverlay({
//     required this.isLoading,
//     required this.child,
//      this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         child,
//         isLoading
//             ? Container(
//                 color: Colors.black.withOpacity(0.5), // Opacité pour l'arrière-plan
//                 child: Center(
//                   child: CircularProgressIndicator(
//                       backgroundColor: (Color.fromARGB(255, 180, 224, 182)),
//           color: (vert),
//                   ), 
//                   // Indicateur de chargement
//                 ),
//               )
//             : SizedBox(), // Utilisé pour cacher l'indicateur de chargement
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(vert), // Remplace orange par bleu
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showLoadingDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(message: message),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}