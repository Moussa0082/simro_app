import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Prix_Marche_Consommation.dart';

class DetailPrixMarcheConsommationScreen extends StatefulWidget {
  final PrixMarcheConsommation? prixMarcheConsommation;
  
  DetailPrixMarcheConsommationScreen({super.key, this.prixMarcheConsommation});

  @override
  State<DetailPrixMarcheConsommationScreen> createState() => _DetailPrixMarcheConsommationScreenState();
}

class _DetailPrixMarcheConsommationScreenState extends State<DetailPrixMarcheConsommationScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails Prix Marché Consommation", style: TextStyle(color: blanc)),
        centerTitle: true,
        backgroundColor: vert,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: blanc),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Utilisation de l'objet PrixMarcheConsommation pour afficher les détails
              buildDetailRow("Produit:", widget.prixMarcheConsommation?.produit ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("N° Fiche :", widget.prixMarcheConsommation?.id_fiche?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Collecteur :", widget.prixMarcheConsommation?.id_personnel ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Date Enregistrement :", widget.prixMarcheConsommation?.date_enregistrement ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Statut :", widget.prixMarcheConsommation?.statut == 0 ? "En attente" : "Terminé"),
              Divider(thickness: 1),
              buildDetailRow("Poids Unitaire :", widget.prixMarcheConsommation?.poids_unitaire?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Prix Mesure :", widget.prixMarcheConsommation?.prix_mesure?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Prix par KG/Litre :", widget.prixMarcheConsommation?.prix_kg_litre?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Niveau Approvisionnement :", widget.prixMarcheConsommation?.niveau_approvisionement?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Observation :", widget.prixMarcheConsommation?.observation ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Document :", widget.prixMarcheConsommation?.document ?? 'Non disponible'),
              Divider(thickness: 1),
              SizedBox(height: 20),
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
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
