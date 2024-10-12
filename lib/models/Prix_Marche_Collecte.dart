// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PrixMarcheCollecte {
    int? enquete;
    String? produit;
    int? unite;
    int? isSynced;
    double? poids_unitaire;
    double? montant_achat;
    double? prix_fg_kg;
    String? localite_origine;
    double? distance_origine_marche;
    int? montant_transport;
    String? etat_route;
    double? quantite_collecte;
    int? client_principal;
    int? fournisseur_principal;
    int? niveau_approvisionement;
    int? app_mobile;
    String? observation;
    int? statut;
    String? id_personnel;
    String? date_enregistrement;
    String? modifier_le;
    String? modifier_par;
    int? id_fiche;

    PrixMarcheCollecte({
         this.enquete,
         this.produit,
         this.unite,
         this.isSynced,
         this.poids_unitaire,
         this.montant_achat,
         this.prix_fg_kg,
         this.localite_origine,
         this.distance_origine_marche,
         this.montant_transport,
         this.etat_route,
         this.quantite_collecte,
         this.client_principal,
         this.fournisseur_principal,
         this.niveau_approvisionement,
         this.app_mobile,
         this.observation,
         this.statut,
         this.id_personnel,
         this.date_enregistrement,
         this.modifier_le,
         this.modifier_par,
         this.id_fiche,
    }); 

    

  PrixMarcheCollecte copyWith({
    int? enquete,
    String? produit,
    int? unite,
    int? isSynced,
    double? poids_unitaire,
    double? montant_achat,
    double? prix_fg_kg,
    String? localite_origine,
    double? distance_origine_marche,
    int? montant_transport,
    String? etat_route,
    double? quantite_collecte,
    int? client_principal,
    int? fournisseur_principal,
    int? niveau_approvisionement,
    int? app_mobile,
    String? observation,
    int? statut,
    String? id_personnel,
    String? date_enregistrement,
    String? modifier_le,
    String? modifier_par,
    int? id_fiche,
  }) {
    return PrixMarcheCollecte(
      enquete: enquete ?? this.enquete,
      produit: produit ?? this.produit,
      unite: unite ?? this.unite,
      isSynced: isSynced ?? this.isSynced,
      poids_unitaire: poids_unitaire ?? this.poids_unitaire,
      montant_achat: montant_achat ?? this.montant_achat,
      prix_fg_kg: prix_fg_kg ?? this.prix_fg_kg,
      localite_origine: localite_origine ?? this.localite_origine,
      distance_origine_marche: distance_origine_marche ?? this.distance_origine_marche,
      montant_transport: montant_transport ?? this.montant_transport,
      etat_route: etat_route ?? this.etat_route,
      quantite_collecte: quantite_collecte ?? this.quantite_collecte,
      client_principal: client_principal ?? this.client_principal,
      fournisseur_principal: fournisseur_principal ?? this.fournisseur_principal,
      niveau_approvisionement: niveau_approvisionement ?? this.niveau_approvisionement,
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
      'produit': produit,
      'unite': unite,
      'isSynced': isSynced,
      'poids_unitaire': poids_unitaire,
      'montant_achat': montant_achat,
      'prix_fg_kg': prix_fg_kg,
      'localite_origine': localite_origine,
      'distance_origine_marche': distance_origine_marche,
      'montant_transport': montant_transport,
      'etat_route': etat_route,
      'quantite_collecte': quantite_collecte,
      'client_principal': client_principal,
      'fournisseur_principal': fournisseur_principal,
      'niveau_approvisionement': niveau_approvisionement,
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

  factory PrixMarcheCollecte.fromMap(Map<String, dynamic> map) {
    return PrixMarcheCollecte(
      enquete: map['enquete'] != null ? map['enquete'] as int : null,
      produit: map['produit'] != null ? map['produit'] as String : null,
      unite: map['unite'] != null ? map['unite'] as int : null,
      isSynced: map['isSynced'] != null ? map['isSynced'] as int : null,
      poids_unitaire: map['poids_unitaire'] != null ? map['poids_unitaire'] as double : null,
      montant_achat: map['montant_achat'] != null ? map['montant_achat'] as double : null,
      prix_fg_kg: map['prix_fg_kg'] != null ? map['prix_fg_kg'] as double : null,
      localite_origine: map['localite_origine'] != null ? map['localite_origine'] as String : null,
      distance_origine_marche: map['distance_origine_marche'] != null ? map['distance_origine_marche'] as double : null,
      montant_transport: map['montant_transport'] != null ? map['montant_transport'] as int : null,
      etat_route: map['etat_route'] != null ? map['etat_route'] as String : null,
      quantite_collecte: map['quantite_collecte'] != null ? map['quantite_collecte'] as double : null,
      client_principal: map['client_principal'] != null ? map['client_principal'] as int : null,
      fournisseur_principal: map['fournisseur_principal'] != null ? map['fournisseur_principal'] as int : null,
      niveau_approvisionement: map['niveau_approvisionement'] != null ? map['niveau_approvisionement'] as int : null,
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

  factory PrixMarcheCollecte.fromJson(String source) => PrixMarcheCollecte.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrixMarcheCollecte(enquete: $enquete, produit: $produit, unite: $unite, isSynced: $isSynced, poids_unitaire: $poids_unitaire, montant_achat: $montant_achat, prix_fg_kg: $prix_fg_kg, localite_origine: $localite_origine, distance_origine_marche: $distance_origine_marche, montant_transport: $montant_transport, etat_route: $etat_route, quantite_collecte: $quantite_collecte, client_principal: $client_principal, fournisseur_principal: $fournisseur_principal, niveau_approvisionement: $niveau_approvisionement, app_mobile: $app_mobile, observation: $observation, statut: $statut, id_personnel: $id_personnel, date_enregistrement: $date_enregistrement, modifier_le: $modifier_le, modifier_par: $modifier_par, id_fiche: $id_fiche)';
  }

  @override
  bool operator ==(covariant PrixMarcheCollecte other) {
    if (identical(this, other)) return true;
  
    return 
      other.enquete == enquete &&
      other.produit == produit &&
      other.unite == unite &&
      other.isSynced == isSynced &&
      other.poids_unitaire == poids_unitaire &&
      other.montant_achat == montant_achat &&
      other.prix_fg_kg == prix_fg_kg &&
      other.localite_origine == localite_origine &&
      other.distance_origine_marche == distance_origine_marche &&
      other.montant_transport == montant_transport &&
      other.etat_route == etat_route &&
      other.quantite_collecte == quantite_collecte &&
      other.client_principal == client_principal &&
      other.fournisseur_principal == fournisseur_principal &&
      other.niveau_approvisionement == niveau_approvisionement &&
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
      produit.hashCode ^
      unite.hashCode ^
      isSynced.hashCode ^
      poids_unitaire.hashCode ^
      montant_achat.hashCode ^
      prix_fg_kg.hashCode ^
      localite_origine.hashCode ^
      distance_origine_marche.hashCode ^
      montant_transport.hashCode ^
      etat_route.hashCode ^
      quantite_collecte.hashCode ^
      client_principal.hashCode ^
      fournisseur_principal.hashCode ^
      niveau_approvisionement.hashCode ^
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
