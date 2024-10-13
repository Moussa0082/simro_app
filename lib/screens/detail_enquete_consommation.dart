import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Enquete.dart';
import 'package:simro/models/Enquete_Collecte.dart';

class DetailEnqueteConsommationScreen extends StatefulWidget {
    Enquete? enqueteConsommation;
   DetailEnqueteConsommationScreen({super.key, this.enqueteConsommation});

  @override
  State<DetailEnqueteConsommationScreen> createState() => _DetailEnqueteConsommationScreenState();
}

class _DetailEnqueteConsommationScreenState extends State<DetailEnqueteConsommationScreen> { 
    
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails Enquete Consommation" ,style: TextStyle(color: blanc),),
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
              buildDetailRow("Marché:", widget.enqueteConsommation!.marche!),
              Divider(thickness: 1),
              buildDetailRow("Collecteur :",  widget.enqueteConsommation!.collecteur!.toString()),
              Divider(thickness: 1),
              buildDetailRow("Date Enquête :",  widget.enqueteConsommation!.date_enquete!),
              Divider(thickness: 1),
              buildDetailRow("Statut :",  widget.enqueteConsommation!.statut!),
              Divider(thickness: 1),
              buildDetailRow("Observation :",  widget.enqueteConsommation!.observation!),
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