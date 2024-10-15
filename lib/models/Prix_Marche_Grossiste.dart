// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PrixMarcheGrossiste {
    int? enquete;
    String? grossiste;
    String? produit;
    int? unite_stock;
    double? nombre_unite_stock;
    double? poids_moyen_unite_stock;
    double? poids_stock;
    int? unite_achat;
    int? isSynced;
    double? nombre_unite_achat;
    double? poids_moyen_unite_achat;
    double? poids_total_achat;
    String? localite_achat;
    int? fournisseur_achat;
    int? unite_vente;
    double? nombre_unite_vente;
    double? poids_moyen_unite_vente;
    double? poids_total_unite_vente;
    double? prix_unitaire_vente;
    int? client_vente;
    String? localite_vente;
    int? app_mobile;
    String? observation;
    int? statut;
    String? id_personnel;
    String? date_enregistrement;
    String? modifier_le;
    String? modifier_par;
    int? id_fiche;

  PrixMarcheGrossiste({
    this.enquete,
    this.grossiste,
    this.produit,
    this.unite_stock,
    this.nombre_unite_stock,
    this.poids_moyen_unite_stock,
    this.poids_stock,
    this.unite_achat,
    this.isSynced,
    this.nombre_unite_achat,
    this.poids_moyen_unite_achat,
    this.poids_total_achat,
    this.localite_achat,
    this.fournisseur_achat,
    this.unite_vente,
    this.nombre_unite_vente,
    this.poids_moyen_unite_vente,
    this.poids_total_unite_vente,
    this.prix_unitaire_vente,
    this.client_vente,
    this.localite_vente,
    this.app_mobile,
    this.observation,
    this.statut,
    this.id_personnel,
    this.date_enregistrement,
    this.modifier_le,
    this.modifier_par,
    this.id_fiche,
  });



  PrixMarcheGrossiste copyWith({
    int? enquete,
    String? grossiste,
    String? produit,
    int? unite_stock,
    int? id_code_mobile,
    double? nombre_unite_stock,
    double? poids_moyen_unite_stock,
    double? poids_stock,
    int? unite_achat,
    int? isSynced,
    double? nombre_unite_achat,
    double? poids_moyen_unite_achat,
    double? poids_total_achat,
    String? localite_achat,
    int? fournisseur_achat,
    int? unite_vente,
    double? nombre_unite_vente,
    double? poids_moyen_unite_vente,
    double? poids_total_unite_vente,
    double? prix_unitaire_vente,
    int? client_vente,
    String? localite_vente,
    int? app_mobile,
    String? observation,
    int? statut,
    String? id_personnel,
    String? date_enregistrement,
    String? modifier_le,
    String? modifier_par,
    int? id_fiche,
  }) {
    return PrixMarcheGrossiste(
      enquete: enquete ?? this.enquete,
      grossiste: grossiste ?? this.grossiste,
      produit: produit ?? this.produit,
      unite_stock: unite_stock ?? this.unite_stock,
      nombre_unite_stock: nombre_unite_stock ?? this.nombre_unite_stock,
      poids_moyen_unite_stock: poids_moyen_unite_stock ?? this.poids_moyen_unite_stock,
      poids_stock: poids_stock ?? this.poids_stock,
      unite_achat: unite_achat ?? this.unite_achat,
      isSynced: isSynced ?? this.isSynced,
      nombre_unite_achat: nombre_unite_achat ?? this.nombre_unite_achat,
      poids_moyen_unite_achat: poids_moyen_unite_achat ?? this.poids_moyen_unite_achat,
      poids_total_achat: poids_total_achat ?? this.poids_total_achat,
      localite_achat: localite_achat ?? this.localite_achat,
      fournisseur_achat: fournisseur_achat ?? this.fournisseur_achat,
      unite_vente: unite_vente ?? this.unite_vente,
      nombre_unite_vente: nombre_unite_vente ?? this.nombre_unite_vente,
      poids_moyen_unite_vente: poids_moyen_unite_vente ?? this.poids_moyen_unite_vente,
      poids_total_unite_vente: poids_total_unite_vente ?? this.poids_total_unite_vente,
      prix_unitaire_vente: prix_unitaire_vente ?? this.prix_unitaire_vente,
      client_vente: client_vente ?? this.client_vente,
      localite_vente: localite_vente ?? this.localite_vente,
      app_mobile: app_mobile ?? this.app_mobile,
      observation: observation ?? this.observation,
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
      'grossiste': grossiste,
      'produit': produit,
      'unite_stock': unite_stock,
      'nombre_unite_stock': nombre_unite_stock,
      'poids_moyen_unite_stock': poids_moyen_unite_stock,
      'poids_stock': poids_stock,
      'unite_achat': unite_achat,
      'isSynced': isSynced,
      'nombre_unite_achat': nombre_unite_achat,
      'poids_moyen_unite_achat': poids_moyen_unite_achat,
      'poids_total_achat': poids_total_achat,
      'localite_achat': localite_achat,
      'fournisseur_achat': fournisseur_achat,
      'unite_vente': unite_vente,
      'nombre_unite_vente': nombre_unite_vente,
      'poids_moyen_unite_vente': poids_moyen_unite_vente,
      'poids_total_unite_vente': poids_total_unite_vente,
      'prix_unitaire_vente': prix_unitaire_vente,
      'client_vente': client_vente,
      'localite_vente': localite_vente,
      'app_mobile': app_mobile,
      'observation': observation,
      'statut': statut,
      'id_personnel': id_personnel,
      'date_enregistrement': date_enregistrement,
      'modifier_le': modifier_le,
      'modifier_par': modifier_par,
      'id_fiche': id_fiche,
    };
  }

  factory PrixMarcheGrossiste.fromMap(Map<String, dynamic> map) {
    return PrixMarcheGrossiste(
      enquete: map['enquete'] != null ? map['enquete'] as int : null,
      grossiste: map['grossiste'] != null ? map['grossiste'] as String : null,
      produit: map['produit'] != null ? map['produit'] as String : null,
      unite_stock: map['unite_stock'] != null ? map['unite_stock'] as int : null,
      nombre_unite_stock: map['nombre_unite_stock'] != null ? map['nombre_unite_stock'] as double : null,
      poids_moyen_unite_stock: map['poids_moyen_unite_stock'] != null ? map['poids_moyen_unite_stock'] as double : null,
      poids_stock: map['poids_stock'] != null ? map['poids_stock'] as double : null,
      unite_achat: map['unite_achat'] != null ? map['unite_achat'] as int : null,
      isSynced: map['isSynced'] != null ? map['isSynced'] as int : null,
      nombre_unite_achat: map['nombre_unite_achat'] != null ? map['nombre_unite_achat'] as double : null,
      poids_moyen_unite_achat: map['poids_moyen_unite_achat'] != null ? map['poids_moyen_unite_achat'] as double : null,
      poids_total_achat: map['poids_total_achat'] != null ? map['poids_total_achat'] as double : null,
      localite_achat: map['localite_achat'] != null ? map['localite_achat'] as String : null,
      fournisseur_achat: map['fournisseur_achat'] != null ? map['fournisseur_achat'] as int : null,
      unite_vente: map['unite_vente'] != null ? map['unite_vente'] as int : null,
      nombre_unite_vente: map['nombre_unite_vente'] != null ? map['nombre_unite_vente'] as double : null,
      poids_moyen_unite_vente: map['poids_moyen_unite_vente'] != null ? map['poids_moyen_unite_vente'] as double : null,
      poids_total_unite_vente: map['poids_total_unite_vente'] != null ? map['poids_total_unite_vente'] as double : null,
prix_unitaire_vente: map['prix_unitaire_vente'] != null
    ? (map['prix_unitaire_vente'] is int 
        ? (map['prix_unitaire_vente'] as int).toDouble() 
        : map['prix_unitaire_vente'] as double)
    : null,

      client_vente: map['client_vente'] != null ? map['client_vente'] as int : null,
      localite_vente: map['localite_vente'] != null ? map['localite_vente'] as String : null,
      app_mobile: map['app_mobile'] != null ? map['app_mobile'] as int : null,
      observation: map['observation'] != null ? map['observation'] as String : null,
      statut: map['statut'] != null ? map['statut'] as int : null,
      id_personnel: map['id_personnel'] != null ? map['id_personnel'] as String : null,
      date_enregistrement: map['date_enregistrement'] != null ? map['date_enregistrement'] as String : null,
      modifier_le: map['modifier_le'] != null ? map['modifier_le'] as String : null,
      modifier_par: map['modifier_par'] != null ? map['modifier_par'] as String : null,
      id_fiche: map['id_fiche'] != null ? map['id_fiche'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrixMarcheGrossiste.fromJson(String source) => PrixMarcheGrossiste.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrixMarcheGrossiste(enquete: $enquete, grossiste: $grossiste, produit: $produit, unite_stock: $unite_stock, nombre_unite_stock: $nombre_unite_stock, poids_moyen_unite_stock: $poids_moyen_unite_stock, poids_stock: $poids_stock, unite_achat: $unite_achat, isSynced: $isSynced,  nombre_unite_achat: $nombre_unite_achat, poids_moyen_unite_achat: $poids_moyen_unite_achat, poids_total_achat: $poids_total_achat, localite_achat: $localite_achat, fournisseur_achat: $fournisseur_achat, unite_vente: $unite_vente, nombre_unite_vente: $nombre_unite_vente, poids_moyen_unite_vente: $poids_moyen_unite_vente, poids_total_unite_vente: $poids_total_unite_vente, prix_unitaire_vente: $prix_unitaire_vente, client_vente: $client_vente, localite_vente: $localite_vente, app_mobile: $app_mobile, observation: $observation, statut: $statut, id_personnel: $id_personnel, date_enregistrement: $date_enregistrement, modifier_le: $modifier_le, modifier_par: $modifier_par, id_fiche: $id_fiche)';
  }

  @override
  bool operator ==(covariant PrixMarcheGrossiste other) {
    if (identical(this, other)) return true;
  
    return 
      other.enquete == enquete &&
      other.grossiste == grossiste &&
      other.produit == produit &&
      other.unite_stock == unite_stock &&
      other.nombre_unite_stock == nombre_unite_stock &&
      other.poids_moyen_unite_stock == poids_moyen_unite_stock &&
      other.poids_stock == poids_stock &&
      other.unite_achat == unite_achat &&
      other.isSynced == isSynced &&
      other.nombre_unite_achat == nombre_unite_achat &&
      other.poids_moyen_unite_achat == poids_moyen_unite_achat &&
      other.poids_total_achat == poids_total_achat &&
      other.localite_achat == localite_achat &&
      other.fournisseur_achat == fournisseur_achat &&
      other.unite_vente == unite_vente &&
      other.nombre_unite_vente == nombre_unite_vente &&
      other.poids_moyen_unite_vente == poids_moyen_unite_vente &&
      other.poids_total_unite_vente == poids_total_unite_vente &&
      other.prix_unitaire_vente == prix_unitaire_vente &&
      other.client_vente == client_vente &&
      other.localite_vente == localite_vente &&
      other.app_mobile == app_mobile &&
      other.observation == observation &&
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
      grossiste.hashCode ^
      produit.hashCode ^
      unite_stock.hashCode ^
      nombre_unite_stock.hashCode ^
      poids_moyen_unite_stock.hashCode ^
      poids_stock.hashCode ^
      unite_achat.hashCode ^
      isSynced.hashCode ^
      nombre_unite_achat.hashCode ^
      poids_moyen_unite_achat.hashCode ^
      poids_total_achat.hashCode ^
      localite_achat.hashCode ^
      fournisseur_achat.hashCode ^
      unite_vente.hashCode ^
      nombre_unite_vente.hashCode ^
      poids_moyen_unite_vente.hashCode ^
      poids_total_unite_vente.hashCode ^
      prix_unitaire_vente.hashCode ^
      client_vente.hashCode ^
      localite_vente.hashCode ^
      app_mobile.hashCode ^
      observation.hashCode ^
      statut.hashCode ^
      id_personnel.hashCode ^
      date_enregistrement.hashCode ^
      modifier_le.hashCode ^
      modifier_par.hashCode ^
      id_fiche.hashCode;
  }
}
