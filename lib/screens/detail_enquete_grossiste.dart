import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Enquete_Grossiste.dart';

class DetailEnqueteGrossisteScreen extends StatefulWidget {
   EnqueteGrossiste? enqueteGrossiste;
   DetailEnqueteGrossisteScreen({super.key, this.enqueteGrossiste});

  @override
  State<DetailEnqueteGrossisteScreen> createState() => _DetailEnqueteGrossisteScreenState();
}

class _DetailEnqueteGrossisteScreenState extends State<DetailEnqueteGrossisteScreen> {
  
  
  
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails enquete grossiste" ,style: TextStyle(color: blanc),),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailRow("Marché :", widget.enqueteGrossiste!.marche!  ?? "Non defini"),
              Divider(thickness: 1),
              buildDetailRow("N° Fiche :", widget.enqueteGrossiste!.num_fiche!  ?? "Non defini"),
              Divider(thickness: 1),
              buildDetailRow("Date Enquête :", widget.enqueteGrossiste!.date_enquete!  ?? "Non defini"),
              Divider(thickness: 1),
              buildDetailRow("Collecteur :", widget.enqueteGrossiste!.collecteur!  ?? "Non defini"),
              Divider(thickness: 1),
              // buildDetailRow("Statut :", "Terminé"),
              Divider(thickness: 1),
              SizedBox(height: 20),
              // Center(
                // child: ElevatedButton(
                //   onPressed: () {
                //     // Action à définir pour le bouton si besoin
                //     print("Action sur le bouton");
                //   },
                //   child: Text("Action supplémentaire"),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: vert, // Couleur du bouton
                //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                //   ),
                // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour créer chaque ligne de détail
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}