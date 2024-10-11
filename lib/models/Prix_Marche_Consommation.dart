// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PrixMarcheConsommation {
    int enquete;
    String produit;
    int unite;
    int poids_unitaire;
    int prix_mesure;
    int prix_kg_litre;
    int niveau_approvisionement;
    String observation;
    String document;
    int appMobile;
    int statut;
    String idPersonnel;
    DateTime date_enregistrement;
    DateTime modifier_le;
    String modifier_par;
    int id_fiche;

    PrixMarcheConsommation({
        required this.enquete,
        required this.produit,
        required this.unite,
        required this.poids_unitaire,
        required this.prix_mesure,
        required this.prix_kg_litre,
        required this.niveau_approvisionement,
        required this.observation,
        required this.document,
        required this.appMobile,
        required this.statut,
        required this.idPersonnel,
        required this.date_enregistrement,
        required this.modifier_le,
        required this.modifier_par,
        required this.id_fiche,
    });



  PrixMarcheConsommation copyWith({
    int? enquete,
    String? produit,
    int? unite,
    int? poids_unitaire,
    int? prix_mesure,
    int? prix_kg_litre,
    int? niveau_approvisionement,
    String? observation,
    String? document,
    int? appMobile,
    int? statut,
    String? idPersonnel,
    DateTime? date_enregistrement,
    DateTime? modifier_le,
    String? modifier_par,
    int? id_fiche,
  }) {
    return PrixMarcheConsommation(
      enquete: enquete ?? this.enquete,
      produit: produit ?? this.produit,
      unite: unite ?? this.unite,
      poids_unitaire: poids_unitaire ?? this.poids_unitaire,
      prix_mesure: prix_mesure ?? this.prix_mesure,
      prix_kg_litre: prix_kg_litre ?? this.prix_kg_litre,
      niveau_approvisionement: niveau_approvisionement ?? this.niveau_approvisionement,
      observation: observation ?? this.observation,
      document: document ?? this.document,
      appMobile: appMobile ?? this.appMobile,
      statut: statut ?? this.statut,
      idPersonnel: idPersonnel ?? this.idPersonnel,
      date_enregistrement: date_enregistrement ?? this.date_enregistrement,
      modifier_le: modifier_le ?? this.modifier_le,
      modifier_par: modifier_par ?? this.modifier_par,
      id_fiche: id_fiche ?? this.id_fiche,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enquete': enquete,
      'produit': produit,
      'unite': unite,
      'poids_unitaire': poids_unitaire,
      'prix_mesure': prix_mesure,
      'prix_kg_litre': prix_kg_litre,
      'niveau_approvisionement': niveau_approvisionement,
      'observation': observation,
      'document': document,
      'appMobile': appMobile,
      'statut': statut,
      'idPersonnel': idPersonnel,
      'date_enregistrement': date_enregistrement.millisecondsSinceEpoch,
      'modifier_le': modifier_le.millisecondsSinceEpoch,
      'modifier_par': modifier_par,
      'id_fiche': id_fiche,
    };
  }

  factory PrixMarcheConsommation.fromMap(Map<String, dynamic> map) {
    return PrixMarcheConsommation(
      enquete: map['enquete'] as int,
      produit: map['produit'] as String,
      unite: map['unite'] as int,
      poids_unitaire: map['poids_unitaire'] as int,
      prix_mesure: map['prix_mesure'] as int,
      prix_kg_litre: map['prix_kg_litre'] as int,
      niveau_approvisionement: map['niveau_approvisionement'] as int,
      observation: map['observation'] as String,
      document: map['document'] as String,
      appMobile: map['appMobile'] as int,
      statut: map['statut'] as int,
      idPersonnel: map['idPersonnel'] as String,
      date_enregistrement: DateTime.fromMillisecondsSinceEpoch(map['date_enregistrement'] as int),
      modifier_le: DateTime.fromMillisecondsSinceEpoch(map['modifier_le'] as int),
      modifier_par: map['modifier_par'] as String,
      id_fiche: map['id_fiche'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrixMarcheConsommation.fromJson(String source) => PrixMarcheConsommation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrixMarcheConsommation(enquete: $enquete, produit: $produit, unite: $unite, poids_unitaire: $poids_unitaire, prix_mesure: $prix_mesure, prix_kg_litre: $prix_kg_litre, niveau_approvisionement: $niveau_approvisionement, observation: $observation, document: $document, appMobile: $appMobile, statut: $statut, idPersonnel: $idPersonnel, date_enregistrement: $date_enregistrement, modifier_le: $modifier_le, modifier_par: $modifier_par, id_fiche: $id_fiche)';
  }

  @override
  bool operator ==(covariant PrixMarcheConsommation other) {
    if (identical(this, other)) return true;
  
    return 
      other.enquete == enquete &&
      other.produit == produit &&
      other.unite == unite &&
      other.poids_unitaire == poids_unitaire &&
      other.prix_mesure == prix_mesure &&
      other.prix_kg_litre == prix_kg_litre &&
      other.niveau_approvisionement == niveau_approvisionement &&
      other.observation == observation &&
      other.document == document &&
      other.appMobile == appMobile &&
      other.statut == statut &&
      other.idPersonnel == idPersonnel &&
      other.date_enregistrement == date_enregistrement &&
      other.modifier_le == modifier_le &&
      other.modifier_par == modifier_par &&
      other.id_fiche == id_fiche;
  }

  @override
  int get hashCode {
    return enquete.hashCode ^
      produit.hashCode ^
      unite.hashCode ^
      poids_unitaire.hashCode ^
      prix_mesure.hashCode ^
      prix_kg_litre.hashCode ^
      niveau_approvisionement.hashCode ^
      observation.hashCode ^
      document.hashCode ^
      appMobile.hashCode ^
      statut.hashCode ^
      idPersonnel.hashCode ^
      date_enregistrement.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_fiche.hashCode;
  }
}
