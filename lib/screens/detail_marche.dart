import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';

class DetailMarcheScreen extends StatefulWidget {
  const DetailMarcheScreen({super.key});

  @override
  State<DetailMarcheScreen> createState() => _DetailMarcheScreenState();
}

class _DetailMarcheScreenState extends State<DetailMarcheScreen> {
 
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails",style: TextStyle(color: blanc),),
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
              buildDetailRow("Nom :", "Marché Bamako"),
              Divider(thickness: 1),
              buildDetailRow("N° Fiche :", "01"),
              Divider(thickness: 1),
              buildDetailRow("Date Enquête :", "17/07/2024"),
              Divider(thickness: 1),
              buildDetailRow("Type Enquête :", "Consommation"),
              Divider(thickness: 1),
              buildDetailRow("Total Collectes :", "54"),
              Divider(thickness: 1),
              buildDetailRow("Collectes Grossiste :", "12"),
              Divider(thickness: 1),
              buildDetailRow("Collectes Consommateur :", "42"),
              Divider(thickness: 1),
              buildDetailRow("Statut :", "Terminé"),
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
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}