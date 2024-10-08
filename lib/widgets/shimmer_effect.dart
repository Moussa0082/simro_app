
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


  // Construire la grille de shimmer pour simuler les cartes produits
   // Shimmer effect for product card
  Widget buildShimmerProductCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simulated product image with shimmer
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Container(
                height: 120,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 100,
                    height: 20.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 150,
                    height: 20.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 120,
                    height: 20.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //filtre btn  
  // Boutons de filtre avec effet shimmer
  Widget buildShimmerFilterButtons() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(5, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 100.0,  // Largeur simulée du bouton
            height: 40.0,  // Hauteur simulée du bouton
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        );
      }),
    );
  }




  // Shimmer effect for product card
  // Construction de la grille des produits avec effet Shimmer
  Widget buildShimmerProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: 6, // Nombre d'éléments shimmer à afficher
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer effect pour l'image du produit
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.white, // Simule l'image en cours de chargement
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shimmer effect pour le titre du produit
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 16.0,
                        width: 100.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Shimmer effect pour le texte du prix
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 14.0,
                        width: 80.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Shimmer effect pour le texte de la disponibilité
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 14.0,
                        width: 120.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Shimmer effect pour le texte de l'origine
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 14.0,
                        width: 100.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


 

 Widget buildShimmerSelectList() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: List.generate(12, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: double.infinity,
            height: 20.0,
            color: Colors.grey[300],
          ),
        );
      }),
    ),
  );
  
}

// liste of collector or enquetor 
// Effet Shimmer pour la liste
  Widget buildShimmerListCorE() {
     return 
     ListView.builder(
       itemCount: 5, // Par exemple, 3 fiches pour l'instant
       itemBuilder: (context, index) {
         return Card(
           margin: EdgeInsets.symmetric(vertical: 10),
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // Shimmer for Title
                 Shimmer.fromColors(
                   baseColor: Colors.grey[300]!,
                   highlightColor: Colors.grey[100]!,
                   child: Container(
                     width: 150,
                     height: 20,
                     color: Colors.white,
                   ),
                 ),
                 SizedBox(height: 5),
                 
                 // Shimmer for Market Text
                 Shimmer.fromColors(
                   baseColor: Colors.grey[300]!,
                   highlightColor: Colors.grey[100]!,
                   child: Container(
                     width: 200,
                     height: 16,
                     color: Colors.white,
                   ),
                 ),
                 SizedBox(height: 5),
                 
                 // Shimmer for Date Text
                 Shimmer.fromColors(
                   baseColor: Colors.grey[300]!,
                   highlightColor: Colors.grey[100]!,
                   child: Container(
                     width: 180,
                     height: 16,
                     color: Colors.white,
                   ),
                 ),
                 SizedBox(height: 5),
                 
                 // Shimmer for Row with Text and PopupMenu
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Shimmer.fromColors(
                       baseColor: Colors.grey[300]!,
                       highlightColor: Colors.grey[100]!,
                       child: Container(
                         width: 180,
                         height: 16,
                         color: Colors.white,
                       ),
                     ),
                     
                     // Shimmer for Popup Menu Button (just an icon shimmer effect)
                     Shimmer.fromColors(
                       baseColor: Colors.grey[300]!,
                       highlightColor: Colors.grey[100]!,
                       child: Container(
                         width: 30,
                         height: 30,
                         color: Colors.white,
                         child: Icon(Icons.more_vert, color: Colors.grey),
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         );
       },
     );
  
}


//Listbuilder shimmer 
Widget buildListBuilder() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget.rectangular(height: 20.0, width: 100),
            SizedBox(height: 5),
            ShimmerWidget.rectangular(height: 20.0, width: 150),
            SizedBox(height: 5),
            ShimmerWidget.rectangular(height: 20.0, width: 200),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rectangular(height: 20.0, width: 150),
                ShimmerWidget.rectangular(height: 20.0, width: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }



//ListBuilder shimmer reste 
class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
  })  : shapeBorder = const RoundedRectangleBorder(),
        super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}