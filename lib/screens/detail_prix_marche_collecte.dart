import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Prix_Marche_Collecte.dart'; // Assure-toi d'importer la classe correctement

class DetailPrixMarcheCollecteScreen extends StatefulWidget {
  final PrixMarcheCollecte? prixMarcheCollecte;
  
  DetailPrixMarcheCollecteScreen({super.key, this.prixMarcheCollecte});

  @override
  State<DetailPrixMarcheCollecteScreen> createState() => _DetailPrixMarcheCollecteScreenState();
}

class _DetailPrixMarcheCollecteScreenState extends State<DetailPrixMarcheCollecteScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails Prix Marche Collecte", style: TextStyle(color: blanc),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        ),
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
              // Utilisation de l'objet PrixMarcheCollecte pour afficher les détails
              buildDetailRow("Marché:", widget.prixMarcheCollecte?.produit ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("N° Fiche :", widget.prixMarcheCollecte?.id_fiche?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Collecteur :", widget.prixMarcheCollecte?.id_personnel ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Date Enquête :", widget.prixMarcheCollecte?.date_enregistrement ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Statut :", widget.prixMarcheCollecte?.statut == 0 ? "En attente" : "Terminé"),
              Divider(thickness: 1),
              buildDetailRow("Quantité Collectée :", widget.prixMarcheCollecte?.quantite_collecte?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Montant Achat :", widget.prixMarcheCollecte?.montant_achat?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Prix FG/KG :", widget.prixMarcheCollecte?.prix_fg_kg?.toString() ?? 'Non disponible'),
              Divider(thickness: 1),
              buildDetailRow("Localité Origine :", widget.prixMarcheCollecte?.localite_origine ?? 'Non disponible'),
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
