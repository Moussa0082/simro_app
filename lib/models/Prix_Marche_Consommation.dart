// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PrixMarcheConsommation {
    int? enquete;
    String? produit;
    int? unite;
    int? isSynced;
    double? poids_unitaire;
    double? prix_mesure;
    double? prix_kg_litre;
    int? niveau_approvisionement;
    String? observation;
    String? document;
    int? app_mobile;
    int? statut;
    String? id_personnel;
    String? date_enregistrement;
    String? modifier_le;
    String? modifier_par;
    int? id_fiche;

    PrixMarcheConsommation({
         this.enquete,
         this.produit,
         this.unite,
        this.isSynced,
         this.poids_unitaire,
         this.prix_mesure,
         this.prix_kg_litre,
         this.niveau_approvisionement,
         this.observation,
         this.document,
         this.app_mobile,
         this.statut,
         this.id_personnel,
         this.date_enregistrement,
         this.modifier_le,
         this.modifier_par,
         this.id_fiche,
    });




  PrixMarcheConsommation copyWith({
    int? enquete,
    String? produit,
    int? unite,
    int? isSynced,
    double? poids_unitaire,
    double? prix_mesure,
    double? prix_kg_litre,
    int? niveau_approvisionement,
    String? observation,
    String? document,
    int? app_mobile,
    int? statut,
    String? id_personnel,
    String? date_enregistrement,
    String? modifier_le,
    String? modifier_par,
    int? id_fiche,
  }) {
    return PrixMarcheConsommation(
      enquete: enquete ?? this.enquete,
      produit: produit ?? this.produit,
      unite: unite ?? this.unite,
      isSynced: isSynced ?? this.isSynced,
      poids_unitaire: poids_unitaire ?? this.poids_unitaire,
      prix_mesure: prix_mesure ?? this.prix_mesure,
      prix_kg_litre: prix_kg_litre ?? this.prix_kg_litre,
      niveau_approvisionement: niveau_approvisionement ?? this.niveau_approvisionement,
      observation: observation ?? this.observation,
      document: document ?? this.document,
      app_mobile: app_mobile ?? this.app_mobile,
      statut: statut ?? this.statut,
      id_personnel: id_personnel ?? this.id_personnel,
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
      'isSynced': isSynced,
      'poids_unitaire': poids_unitaire,
      'prix_mesure': prix_mesure,
      'prix_kg_litre': prix_kg_litre,
      'niveau_approvisionement': niveau_approvisionement,
      'observation': observation,
      'document': document,
      'app_mobile': app_mobile,
      'statut': statut,
      'id_personnel': id_personnel,
      'date_enregistrement': date_enregistrement,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_fiche': id_fiche,
    };
  }

  factory PrixMarcheConsommation.fromMap(Map<String, dynamic> map) {
    return PrixMarcheConsommation(
      enquete: map['enquete'] != null ? map['enquete'] as int : null,
      produit: map['produit'] != null ? map['produit'] as String : null,
      unite: map['unite'] != null ? map['unite'] as int : null,
      isSynced: map['isSynced'] != null ? map['isSynced'] as int : null,
      poids_unitaire: map['poids_unitaire'] != null ? map['poids_unitaire'] as double : null,
      prix_mesure: map['prix_mesure'] != null ? map['prix_mesure'] as double : null,
      prix_kg_litre: map['prix_kg_litre'] != null ? map['prix_kg_litre'] as double : null,
      niveau_approvisionement: map['niveau_approvisionement'] != null ? map['niveau_approvisionement'] as int : null,
      observation: map['observation'] != null ? map['observation'] as String : null,
      document: map['document'] != null ? map['document'] as String : null,
      app_mobile: map['app_mobile'] != null ? map['app_mobile'] as int : null,
      statut: map['statut'] != null ? map['statut'] as int : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_fiche: map['id_fiche'] != null ? map['id_fiche'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrixMarcheConsommation.fromJson(String source) => PrixMarcheConsommation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrixMarcheConsommation(enquete: $enquete, produit: $produit, unite: $unite, isSynced: $isSynced, poids_unitaire: $poids_unitaire, prix_mesure: $prix_mesure, prix_kg_litre: $prix_kg_litre, niveau_approvisionement: $niveau_approvisionement, observation: $observation, document: $document, app_mobile: $app_mobile, statut: $statut, id_personnel: $id_personnel, date_enregistrement: $date_enregistrement, modifier_le: $modifier_le, modifier_par: $modifier_par, id_fiche: $id_fiche)';
  }

  @override
  bool operator ==(covariant PrixMarcheConsommation other) {
    if (identical(this, other)) return true;
  
    return 
      other.enquete == enquete &&
      other.produit == produit &&
      other.unite == unite &&
      other.isSynced == isSynced &&
      other.poids_unitaire == poids_unitaire &&
      other.prix_mesure == prix_mesure &&
      other.prix_kg_litre == prix_kg_litre &&
      other.niveau_approvisionement == niveau_approvisionement &&
      other.observation == observation &&
      other.document == document &&
      other.app_mobile == app_mobile &&
      other.statut == statut &&
      other.id_personnel == id_personnel &&
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
      isSynced.hashCode ^
      poids_unitaire.hashCode ^
      prix_mesure.hashCode ^
      prix_kg_litre.hashCode ^
      niveau_approvisionement.hashCode ^
      observation.hashCode ^
      document.hashCode ^
      app_mobile.hashCode ^
      statut.hashCode ^
      id_personnel.hashCode ^
      date_enregistrement.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_fiche.hashCode;
  }
}
