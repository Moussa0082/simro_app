import 'package:flutter/material.dart';
import 'package:simro/constant/constantes.dart';
import 'package:simro/models/Prix_Marche_Grossiste.dart';

class DetailPrixMarcheGrossisteScreen extends StatefulWidget {
  final PrixMarcheGrossiste? prixMarcheGrossiste;

  DetailPrixMarcheGrossisteScreen({super.key, this.prixMarcheGrossiste});

  @override
  State<DetailPrixMarcheGrossisteScreen> createState() => _DetailPrixMarcheGrossisteScreenState();
}

class _DetailPrixMarcheGrossisteScreenState extends State<DetailPrixMarcheGrossisteScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails Prix Marché Grossiste", style: TextStyle(color: blanc)),
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
              buildDetailRow("Enquête :", widget.prixMarcheGrossiste?.enquete?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Grossiste :", widget.prixMarcheGrossiste?.grossiste ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Produit :", widget.prixMarcheGrossiste?.produit ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Unité de Stock :", widget.prixMarcheGrossiste?.unite_stock?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Nombre d'Unités en Stock :", widget.prixMarcheGrossiste?.nombre_unite_stock?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Poids Moyen Unité Stock :", widget.prixMarcheGrossiste?.poids_moyen_unite_stock?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Poids Stock :", widget.prixMarcheGrossiste?.poids_stock?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Unité d'Achat :", widget.prixMarcheGrossiste?.unite_achat?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Nombre d'Unités d'Achat :", widget.prixMarcheGrossiste?.nombre_unite_achat?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Poids Moyen Unité Achat :", widget.prixMarcheGrossiste?.poids_moyen_unite_achat?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Poids Total Achat :", widget.prixMarcheGrossiste?.poids_total_achat?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Localité d'Achat :", widget.prixMarcheGrossiste?.localite_achat ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Fournisseur d'Achat :", widget.prixMarcheGrossiste?.fournisseur_achat?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Unité de Vente :", widget.prixMarcheGrossiste?.unite_vente?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Nombre d'Unités de Vente :", widget.prixMarcheGrossiste?.nombre_unite_vente?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Poids Moyen Unité Vente :", widget.prixMarcheGrossiste?.poids_moyen_unite_vente?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Poids Total Unité Vente :", widget.prixMarcheGrossiste?.poids_total_unite_vente?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Prix Unitaire Vente :", widget.prixMarcheGrossiste?.prix_unitaire_vente?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Client Vente :", widget.prixMarcheGrossiste?.client_vente?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Localité Vente :", widget.prixMarcheGrossiste?.localite_vente ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Observations :", widget.prixMarcheGrossiste?.observation ?? "Aucune observation"),
              Divider(thickness: 1),
              buildDetailRow("Statut :", widget.prixMarcheGrossiste?.statut?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("ID Personnel :", widget.prixMarcheGrossiste?.id_personnel ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Date d'Enregistrement :", widget.prixMarcheGrossiste?.date_enregistrement ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Modifié le :", widget.prixMarcheGrossiste?.modifier_le ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("Modifié par :", widget.prixMarcheGrossiste?.modifier_par ?? "Non spécifié"),
              Divider(thickness: 1),
              buildDetailRow("ID Fiche :", widget.prixMarcheGrossiste?.id_fiche?.toString() ?? "Non spécifié"),
              Divider(thickness: 1),
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
